---
title: "サイトコレクションを異なる Web アプリケーションにコピーする"
description: "はじめに サイトコレクションのコピー、簡単そうで実は非常に手間のかかる作業です。 AvePoint さんの製品 コンテンツマネージャー を使えば簡単にできてしまいますが、ここでは手動で異なる Web アプリケーションにサイトコレクションをコ…"
date: 2013-09-01T02:47:27+09:00
slug: "5441-web"
categories: ["SharePoint 2013", "インストールと設定、管理"]
aliases: ["/article/5441/"]
draft: false
---
### はじめに

サイトコレクションのコピー、簡単そうで実は非常に手間のかかる作業です。
AvePoint さんの製品 [コンテンツマネージャー](http://www.avepoint.co.jp/sharepoint-content-management-docave/) を使えば簡単にできてしまいますが、ここでは手動で異なる Web アプリケーションにサイトコレクションをコピーする方法をご紹介します。
(2013年9月13日追記)
本記事は2013年9月1日に公開しましたが、マイクロソフトのサポートサービスさんにテクニカルサポートを依頼し、詳細な確認をしていただいたところ、この手順ではコピーはできるものの問題があることが分かりました。
詳細はこの後書きますが、基本的にはこの手順でのコピーは行わないでください。

### Copy-SPSite の問題

Copy-SPSite は、Backup/Restore と同様、SharePoint が内部的に持っている各種 GUID を書き換えることなく、コピーを行います。
そのため、一つのサイトコレクションのコピーを、同一コンテンツ DB に Copy-SPSite を使って複数個コピーすると、GUID が重複してしまい、SharePoint として不整合なデータの状態になってしまうことが分かりました。
これにより、エクスポートでエラーが起きたり、ゴミ箱のアイテムを削除するのにエラーが起きたりと、一部動作に問題がでます。
従って、せっかくの Copy-SPSite ですが、これを使ってサイトコレクションを量産していくということには使えないということになります。
調査の結果、SharePoint 標準機能を使ってサイトコレクションのコピーを完ぺきに実現する方法はない、という結論に至りました。
残念。。。
もちろん、Copy-SPSite を使って、毎回異なるコンテンツ DB にコピーする分には問題なく使えますので、そのような用途でのみ Copy-SPSite を使うようにしてください。

### 概要

今回は http://sp2013dev/sites/test というサイトを、http://sp2013dev:12930/sites/test にコピーする手順を題材にします。
これから説明する手順は、すべて PowerShell で行う必要があるのですが、実行するコマンドが多いので先に全体の流れを説明します。
コピーの全体の流れは以下の通りとなります。
１．サイトコレクションコピー用のコンテンツデータベース作成
２．作成したコピー用コンテンツデータベースにコピー対象となるサイトコレクションをコピー
３．コピー用コンテンツデータベースをコピー元 Web アプリケーションから切り離す
４．コピー用コンテンツデータベースをコピー先 Web アプリケーションに接続
５．コピー用コンテンツデータベースからコピー先 Web アプリケーションの既存コンテンツデータベースにコピー元サイトコレクションをコピー
６．コピー先 Web アプリケーションからコピー用コンテンツデータベースを削除

### 実施手順

それでは１ステップずつ説明します。
まずは、PowerShell を利用するため、SharePoint がインストールされたサーバーにログインして「SharePoint 2013 管理シェル」を起動してください。

#### １．サイトコレクションコピー用のコンテンツデータベース作成

まず、現在のサイトコレクションの状態を確認するため [Get-SPSite](http://technet.microsoft.com/ja-jp/library/ff607950.aspx) コマンドを実行します。
「| select url, id」を付けることで、URL と ID だけを表示するようにしています。

```
1: PS C:> Get-SPSite | select url,id
```
```
2:
```
```
3: Url ID
```
```
4: --- --
```
```
5: http://sp2013dev:12930 a4dc6b0e-6013-4e70-9357-610cae9e1f34
```
```
6: http://sp2013dev/sites/test 14eee793-4466-4ac8-b297-8823a7ccec71
```

続いて、コピー用のコンテンツデータベースを作成するため、[New-SPContentDatabase](http://technet.microsoft.com/ja-jp/library/ff607572.aspx) コマンドを実行します。
ここでは、Web アプリケーション http://sp2013dev にコンテンツデータベース WSS\_Content\_Move を作成します。
コマンドは 2 行になっていますが、実際には 1 行で書いてください。

```
1: New-SPContentDatabase -Name WSS\_Content\_Move
```
```
2: -WebApplication http://sp2013dev
```
```
3:
```
```
4: Id : a2c84a3e-f55b-41f1-934e-8e5c4b29f46b
```
```
5: Name : WSS\_Content\_Move
```
```
6: WebApplication : SPWebApplication Name=SharePoint - 80
```
```
7: Server : SP2013DEVSharePoint
```
```
8: CurrentSiteCount : 0
```

#### ２．作成したコピー用コンテンツデータベースにコピー対象となるサイトコレクションをコピー

サイトコレクション http://sp2013dev/sites/test をコピー用コンテンツデータベースに別名でコピーするため、[Copy-SPSite](http://technet.microsoft.com/ja-jp/library/fp161280.aspx) コマンドを実行します。
コマンドは 3 行になっていますが、実際は 1 行で書いてください。

```
1: PS C:> Copy-SPSite -Identity http://sp2013dev/sites/test
```
```
2: -TargetUrl http://sp2013dev/sites/test\_copy
```
```
3: -DestinationDatabase WSS\_Content\_Move
```

ここで再び Get-SPSite で状態を確認してみます。

```
1: PS C:> Get-SPSite | select url,id
```
```
2:
```
```
3: Url ID
```
```
4: --- --
```
```
5: http://sp2013dev:12930 a4dc6b0e-6013-4e70-9357-610cae9e1f34
```
```
6: http://sp2013dev/sites/test 14eee793-4466-4ac8-b297-8823a7ccec71
```
```
7: http://sp2013dev/sites/test\_copy 31d5ea5e-1fa7-42f5-a56e-039e656f8fdd
```

7 行目のサイトコレクションが、6 行目のサイトコレクションからコピーされたサイトコレクションになります。

#### ３．コピー用コンテンツデータベースをコピー元 Web アプリケーションから切り離す

コピー用コンテンツデータベースをコピー元 Web アプリケーションから切り離し、コピー先に移動できるようにするため、[Dismount-SPContentDatabase](http://technet.microsoft.com/ja-jp/library/ff607764.aspx) コマンドを実行します。

```
1: PS C:> Dismount-SPContentDatabase -Identity WSS\_Content\_Move
```
```
2:
```
```
3: 確認
```
```
4: この操作を実行しますか?
```
```
5: 対象 "WSS\_Content\_Move" に対して操作 "Dismount-SPContentDatabase"
```
```
6: を実行しています。
```
```
7: [Y] はい(Y) [A] すべて続行(A) [N] いいえ(N) [L] すべて無視(L) [S] 中断(S)
```
```
8: [?] ヘルプ(既定値は "Y"): Y
```

#### ４．コピー用コンテンツデータベースをコピー先 Web アプリケーションに接続

コピー先 Web アプリケーションにコピー用コンテンツデータベースを接続するため、[Mount-SPContentDatabase](http://technet.microsoft.com/ja-jp/library/ff607581.aspx) コマンドを実行します。

```
1: PS C:> Mount-SPContentDatabase -Name WSS\_Content\_Move
```
```
2: -WebApplication http://sp2013dev:12930
```
```
3:
```
```
4: Id : a2c84a3e-f55b-41f1-934e-8e5c4b29f46b
```
```
5: Name : WSS\_Content\_Move
```
```
6: WebApplication : SPWebApplication Name=SharePoint - 12930
```
```
7: Server : SP2013DEVSharePoint
```
```
8: CurrentSiteCount : 1
```

ここで再び Get-SPSite コマンドを実行して、サイトコレクションがコピーできていることを確認します。

```
1: PS C:> Get-SPSite | select url,id
```
```
2:
```
```
3: Url ID
```
```
4: --- --
```
```
5: http://sp2013dev:12930 a4dc6b0e-6013-4e70-9357-610cae9e1f34
```
```
6: http://sp2013dev:12930/sites/test\_copy 31d5ea5e-1fa7-42f5-a56e-039e656f8fdd
```
```
7: http://sp2013dev/sites/test 14eee793-4466-4ac8-b297-8823a7ccec71
```

6 行目のサイトコレクション test\_copy が、Web アプリケーション sp2013dev:12930 に含まれていることが確認できます。
ただし、この状態ではまだコピー用コンテンツデータベースに属している状態なので、次のステップで、sp2013dev:12930 の既存のコンテンツデータベースにサイトコレクションを移動します。

#### ５．コピー用コンテンツデータベースからコピー先 Web アプリケーションの既存コンテンツデータベースにコピー元サイトコレクションをコピー

コピー先 Web アプリケーション http://sp2013dev:12930 の既存のコンテンツデータベース WSS\_Content\_ebed969934304a32a00c5118674fb677 にサイトコレクションをコピーするため、Copy-SPSite コマンドを実行します。
コマンドは 3 行になっていますが、実際は 1 行で書いてください。

```
1: PS C:> Copy-SPSite -Identity http://sp2013dev:12930/sites/test\_copy
```
```
2: -TargetUrl http://sp2013dev:12930/sites/test
```
```
3: -DestinationDatabase WSS\_Content\_ebed969934304a32a00c5118674fb677
```

 
では、Get-SPSite コマンドできちんとコピーされたか確認します。

```
1: PS C:> Get-SPSite | select url,id
```
```
2:
```
```
3: Url ID
```
```
4: --- --
```
```
5: http://sp2013dev:12930 a4dc6b0e-6013-4e70-9357-610cae9e1f34
```
```
6: http://sp2013dev:12930/sites/test d2aa70b4-9948-4ff7-b60e-801f1ac5d452
```
```
7: http://sp2013dev:12930/sites/test\_copy 31d5ea5e-1fa7-42f5-a56e-039e656f8fdd
```
```
8: http://sp2013dev/sites/test 14eee793-4466-4ac8-b297-8823a7ccec71
```

6 行目のサイトコレクションが、8 行目のサイトコレクションのコピーとなります。
ここで、ブラウザから実際にサイトコレクションにアクセスして、コピーされているかどうか確認してください。
問題なければ、次のステップで 7 行目のサイトコレクションを消します。

#### ６．コピー先 Web アプリケーションからコピー用コンテンツデータベースを削除

最後にコピー用使ったコンテンツデータベースとサイトコレクションを削除します。
コンテンツデータベースを消すことで、サイトコレクションも消すことができるので、[Remove-SPContentDatabase](http://technet.microsoft.com/ja-jp/library/ff607920.aspx) コマンドを実行しコンテンツデータベースを削除します。

```
1: PS C:> Remove-SPContentDatabase -Identity WSS\_Content\_Move
```
```
2:
```
```
3: 確認
```
```
4: この操作を実行しますか?
```
```
5: 対象 "WSS\_Content\_Move" に対して操作 "Remove-SPContentDatabase"
```
```
6: を実行しています。
```
```
7: [Y] はい(Y) [A] すべて続行(A) [N] いいえ(N) [L] すべて無視(L) [S] 中断(S)
```
```
8: [?] ヘルプ(既定値は "Y"): Y
```
```
9:
```
```
10: 確認
```
```
11: 'WSS\_Content\_Move' を削除すると、SQL
```
```
12: データベースおよびデータベース内に格納されているすべての内容が完全に削除されま
```
```
13: す。SQL データベースを削除しない場合は、Dismount-SPContentDatabase
```
```
14: を使用してください。
```
```
15: [Y] はい(Y) [A] すべて続行(A) [N] いいえ(N) [L] すべて無視(L) [S] 中断(S)
```
```
16: [?] ヘルプ(既定値は "Y"): Y
```

これでコピーが完了しました。
最後に Get-SPSite コマンドで状態を確認します。

```
1: PS C:> Get-SPSite | select url,id
```
```
2:
```
```
3: Url ID
```
```
4: --- --
```
```
5: http://sp2013dev:12930 a4dc6b0e-6013-4e70-9357-610cae9e1f34
```
```
6: http://sp2013dev:12930/sites/test d2aa70b4-9948-4ff7-b60e-801f1ac5d452
```
```
7: http://sp2013dev/sites/test 14eee793-4466-4ac8-b297-8823a7ccec71
```

はい、ゴミも消えて、きちんとコピーされた状態になりました。
上記の通り、非常に手順が多いです。
間違えてもやり直しはききますが、不安な方は市販ツールを使うようにするのが良いと思います。
