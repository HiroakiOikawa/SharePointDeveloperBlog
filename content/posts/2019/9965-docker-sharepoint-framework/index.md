---
title: "Docker を使った SharePoint Framework 開発環境の構築 その２"
description: "はじめに ※2019年12月8日更新 Docker 上に SharePoint Framework の開発環境を構築する手順をまとめました。 この資料の内容は、 こちらのスライド からの抜粋となります。 構築手順をまとめて確認したい方は、ス…"
date: 2019-02-18T12:56:31+09:00
slug: "9965-docker-sharepoint-framework"
categories: ["Office 365", "SharePoint", "開発とプログラミング"]
tags: ["@microsoft/sharepoint", "Docker", "Office 365", "OfficeDev", "SharePoint", "SharePoint Framework", "SPFx", "yo", "構築", "開発環境"]
aliases: ["/article/9965/"]
draft: false
---
# はじめに

※2019年12月8日更新
Docker 上に SharePoint Framework の開発環境を構築する手順をまとめました。
この資料の内容は、[こちらのスライド](https://www.slideshare.net/HiroakiOikawa/sharepoint-framework-teams)からの抜粋となります。
構築手順をまとめて確認したい方は、スライドをダウンロードしてください。
なお、環境構築手順は、
・[開発環境を構築するためにホストとなる PC で行う手順](http://sharepoint.orivers.jp/?p=9954)
・[Docker イメージを準備する手順](http://sharepoint.orivers.jp/?p=9965)
・[Docker 上でプロジェクトごとに行う手順](http://sharepoint.orivers.jp/?p=9998)
の３部構成になっています。
この記事では、Docker イメージを準備する手順について記載します。

# Docker イメージの準備

## SharePoint Framework Docker イメージの取得

開発環境としての SharePoint Framework 実行環境を Docker イメージとして準備します。
準備する方法は大きく 3 つあります。

1. Docker Hub からダウンロード
2. Dockerfile から新規作成

### 1. Docker Hub からダウンロード

Docker Hub とは、Docker のイメージファイルがシェアされている共有リポジトリです。
Docker Hub には、SharePoint Framework の開発に関わる waldekm さんが作成したイメージが登録されており、誰でも自由に利用することができます。
利用方法は以下の通りです。
PowerShell を起動して、以下のコマンドを実行します。
コマンドを実行すると、ローカル PC 上に指定バージョンの Docker イメージが存在しない場合のみ、GetHub から指定のイメージがダウンロードされます。
そして、Docker 上に環境が構築され、環境が起動します。
```
cd [プロジェクトフォルダ]
docker run -it --rm --name [プロジェクト名] -v [プロジェクトフォルダ]:/usr/app/spfx -p 5432:5432 -p 4321:4321 -p 35729:35729 waldekm/spfx:[SPFx バージョン番号]
```
なお、SPFx バージョン番号 を省略すると、最新バージョンのイメージをダウンロードします。
以下、実行コマンドの例です。
```
cd D:\SPFxWork\SampleAppCustom
docker run -it --rm --name SampleAppCustom -v D:\SPFxWork\SampleAppCustom:/usr/app/spfx -p 5432:5432 -p 4321:4321 -p 35729:35729 waldekm/spfx:1.7.1
```
~~ただ、waldekm さんのイメージが、2019年5月にリリースされた SharePoint Framework 1.8.2 を最後に、更新が止まってしまっています。~~
~~今現在は、1.9.1 が最新版となるため、waldekm さんのイメージを利用する場合、1.9.1 を使用することができません。~~
(2019年12月14日現在、waldekm さんが 1.9.1 のイメージをアップされたようです。)
そのため、最新の 1.9.1 に対応した Docker イメージを私が作成して Docker Hub に登録しました。
waldekm さんのイメージの更新が止まっている間は、今後も新しいバージョンの SharePoint Framework がリリースされる度にイメージを登録していきたいと思います。
私の Docker Hub はこちらになります。
<https://hub.docker.com/repository/docker/orivers/spfx>
使用方法は、以下の赤字箇所の通り「waldekm」の部分を「orivers」に置き換えるだけです。
```
cd [プロジェクトフォルダ]
docker run -it --rm --name [プロジェクト名] -v [プロジェクトフォルダ]:/usr/app/spfx -p 5432:5432 -p 4321:4321 -p 35729:35729 orivers/spfx:[SPFx バージョン番号]
```

### 2. Dockerfile から新規作成

Docker イメージは自分で作成することができます。
Docker イメージを作成する際には、Dockerfile という定義ファイルを作成しこれをビルドすることで行います。
私の GitHub に、Dockerfile をアップしているので、これをダウンロード＆ビルドしてイメージを作成します。
私の GitHub はこちらになります。
<https://github.com/HiroakiOikawa/docker-spfx>
Dockerfile をダウンロードした後は、PowerShell を起動して以下のコマンドを実行してください。
```
docker build -t [ラベル] [dockerfileのパス]
```
以下、実行コマンドの例です。カレントフォルダの Dockerfile をビルドします。
```
docker build -t orivers/spfx:1.9.1 .
```

## Docker コンテナの起動、停止確認

準備した Docker イメージを使って、Docker コンテナの起動、停止確認を行います。
まず初めに、Docker の Shared Drive に指定したドライブ上に適当なフォルダを作成してください。
次に、PowerShell で以下のコマンドを実行して Docker コンテナを起動します。
```
docker run -it --rm --name Sample -v [作業フォルダ]:/usr/app/spfx -p 4321:4321 -p 5432:5432 -p 35729:35729 [イメージの名前]
```
以下、実行コマンドの例です。私が作成したイメージ「orivers/spfx:1.9.1」を使用して作業フォルダ「C:\work」を指定して起動します。
```
docker run -it --rm --name Sample -v C:\work:/usr/app/spfx -p 4321:4321 -p 5432:5432 -p 35729:35729 orivers/spfx:1.9.1
```
無事起動できると、Docker のコンソールに接続されて、PowerShell コンソール上に以下のように出力されます。
spfx@9add4e3e420f:/usr/app/spfx$
※下線部分は環境により異なる値になります。
無事起動できた後は、Docker コンテナを停止させます。
Docker のコンソールにて以下のコマンドを実行します。
```
exit
```
 
以上で、Docker を使う準備がすべて整いました。
別記事にて、プロジェクトごとに行う手順について説明します。
[AdSense-B]
