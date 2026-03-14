---
title: "サイトコレクションを指定のコンテンツDBに移動する"
description: "PowerShellを使って、サイトコレクションを別のコンテンツDBに移動する方法です。 移動の前後で サイトコレクションとコンテンツDBの一覧を出力 すると、移動できたかどうかがわかります。"
date: 2010-03-14T02:26:14+09:00
slug: "4001-db"
categories: ["SharePoint 2010", "インストールと設定、管理"]
aliases: ["/article/4001/"]
draft: false
---
PowerShellを使って、サイトコレクションを別のコンテンツDBに移動する方法です。

```
1: #移動したいサイトコレクションを第一パラメータに指定。
```
```
2: #移動先のコンテンツDB名をDestinationDatabaseに指定。
```
```
3: PS C:UsersAdministrator.SP2010RCENT> move-spsite http://sp2010rcent/media -destinationdatabase WSS\_Content\_Media
```
```
4:
```
```
5: 確認
```
```
6: この操作を実行しますか?
```
```
7: 対象 "http://sp2010rcent/media" に対して操作 "Move-SPSite" を実行しています。
```
```
8: [Y] はい(Y) [A] すべて続行(A) [N] いいえ(N) [L] すべて無視(L) [S] 中断(S)
```
```
9: [?] ヘルプ(既定値は "Y"): y
```
```
10:
```
```
11: 警告: この変更を有効にするには IIS を再起動する必要があります。IISを再起動するには、コマンド プロンプトウィンドウを開き「iisreset」と入力します。
```
```
12:
```
```
13: #指示に従いIISRESET実施
```
```
14: PS C:UsersAdministrator.SP2010RCENT> iisreset
```
```
15: 停止中...
```
```
16: インターネット サービスは正常に停止されました
```
```
17: 開始中...
```
```
18: インターネット サービスは正常に再開されました
```

移動の前後で[サイトコレクションとコンテンツDBの一覧を出力](/article/4021)すると、移動できたかどうかがわかります。
