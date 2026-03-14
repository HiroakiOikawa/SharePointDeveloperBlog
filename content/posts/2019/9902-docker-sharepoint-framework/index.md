---
title: "Docker で SharePoint Framework 開発環境を構築する際の注意事項"
description: "Docker を使って SharePoint Framework の開発環境を構築することで、プロジェクト毎の異なる環境要件にも対応できるようになります。 これにより、例えばプロジェクト毎に SharePoint Framework のバー…"
date: 2019-01-27T15:24:35+09:00
slug: "9902-docker-sharepoint-framework"
categories: ["Office 365", "SharePoint", "開発とプログラミング"]
tags: ["Docker image", "SharePoint", "SharePoint Framework", "SPFx", "開発環境"]
aliases: ["/article/9902/"]
draft: false
---
Docker を使って SharePoint Framework の開発環境を構築することで、プロジェクト毎の異なる環境要件にも対応できるようになります。
これにより、例えばプロジェクト毎に SharePoint Framework のバージョンが異なっていたとしても、それぞれのバージョンの Docker 環境を作って問題なく開発することができます。
SharePoint Framework はバージョンアップの頻度が高いため、こうしたバージョンを固定させる環境の仕組みづくりが非常に重要になり、マイクロソフトのサイトでも Docker を使った開発環境についての記載があります。
[SharePoint Framework におけるチーム ベースの開発](https://docs.microsoft.com/ja-jp/sharepoint/dev/spfx/team-based-development-on-sharepoint-framework)
 
とても便利な Docker を使った開発環境ですが、いざ構築しようとするといろいろと問題が発生します。
この投稿では 、私が Docker で SPFx 開発環境を構築する際に発生した問題について、分かっている限りの対応策を紹介したいと思います。

### 問題が発生したことがない条件

Docker による SPFx 開発環境構築で、過去に問題が発生したことがない条件は以下になります。
可能であればこの条件を満たした状態で環境構築をしたいところです。
ただ、あくまでも私が過去に問題が発生しなかっただけで、いかなる場合も問題が発生しないと言っている訳ではないのでご注意ください。

#### パターン１

・PC が オンプレ AD のドメインに参加している。
・ユーザーが オンプレ AD に属するユーザーである。
・ユーザーがローカル PC の Administrators グループに所属している。

#### パターン２

・PC が オンプレ AD のドメインに所属していない。(ワークグループに所属している)
・ユーザーが Microsoft アカウントのユーザーである。
・ユーザーがローカル PC の Administrators グループに所属している。

### 過去に発生した問題

上記条件を満たしていない状態で環境構築をした際に、以下に挙げるような問題に遭遇しました。

#### 問題１

npm install gulp、npm install @microsoft/sp-office-ui-fabric-core --save、yo @microsoft/sharepoint を実行した際に「Error: EACCES」が発生する。

#### 対策１

npm により多数のモジュールがダウンロード&インストールされますが、このエラーは node 上にアクセス権限がない場合に出るようです。
Linux に疎い私はアクセス権限を付けなおさないといけないのか？と思い、[こちらのサイト](https://qiita.com/Gaddict/items/8c76d92bd0adec2bfb6a)を参考に「sudo chmod 777 /usr/local」を試したりしましたが、そもそも「sudo」が使えなかったりしてうまくいきませんでした。
結局私は問題が発生したことがない条件を満たす構成に変更して逃げたのですが、[こちらのサイト](http://tech.guitarrapc.com/entry/2017/12/27/042458)に記載の対応で行けるよという情報がありました。
問題２
yo @microsoft/sharepoint を実行した際に、「Error: EINVAL」などのコンパイルエラーが発生する。

#### 対策２

デフォルト設定では、yo をすると、パッケージマネージャとして npm が使用されますが、npm であるがためにコンパイルエラーになるということがあるようです。
何回やってもコンパイルエラーになるようであれば、以下の通り npm 以外のパッケージマネージャを指定して yo してみてください。
yo @microsoft/sharepoint --package-manager yarn
 
今後も問題を見つけたら追記していきたいと思います。
 
[AdSense-B]
