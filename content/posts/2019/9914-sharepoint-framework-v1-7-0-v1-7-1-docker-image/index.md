---
title: "SharePoint Framework v1.7.0, v1.7.1 Docker image 使用時の注意点"
description: "はじめに Waldek Mastykarz さんが github で公開している docker-spfx ですが、先日 SharePoint Framework v1.7.0、v1.7.1 に対応したイメージが公開されました。 早速この最新…"
date: 2019-02-02T08:11:23+09:00
slug: "9914-sharepoint-framework-v1-7-0-v1-7-1-docker-image"
categories: ["Office 365", "SharePoint", "開発とプログラミング"]
tags: ["Docker image", "SharePoint", "SharePoint Framework", "SPFx", "開発環境"]
aliases: ["/article/9914/"]
draft: false
---
# はじめに

Waldek Mastykarz さんが github で公開している docker-spfx ですが、先日 SharePoint Framework v1.7.0、v1.7.1 に対応したイメージが公開されました。
早速この最新イメージを使って環境構築を行ってみました。
これまでのイメージもそうだったのですが、使用するためには色々と山あり谷ありなので、きちんと動くまでに私が行ったことをメモしておきたいと思います。

# docker-spfx

最新の docker-spfx は、以下の URL からダウンロード可能です。
<https://github.com/waldekmastykarz/docker-spfx>
docker-spfx を使った環境構築の基本については、[昨年 bootcamp にて使用した資料](https://www.slideshare.net/HiroakiOikawa/sharepoint-framework-extension)を参照してください。
なお、最新版である version 1.7.0、1.7.1 のイメージは資料通りに作ってもうまくいかないので、この記事に記載の方法で適宜読み替えてください。

# docker-spfx v1.7.0、1.7.1 を使うために必要なこと

## github に記載の Known issues

まずはこれが必須です。
毎回のリリースごとに Known issues に必要な手順が記載されているので、ご自身の環境に合わせて対応してください。
v1.7.0、1.7.1 を Windows 上の Docker で使用する場合は、以下の 2 つの issue を対応してください。
・[Can't access workbench and bundles in SharePoint Framework 1.6.0/1.7.0/1.7.1](https://github.com/waldekmastykarz/docker-spfx#cant-access-workbench-and-bundles-in-sharepoint-framework-160170171)
・[Can't access workbench and bundles in SharePoint Framework 1.6.0/1.7.0/1.7.1 on Windows](https://github.com/waldekmastykarz/docker-spfx#cant-access-workbench-and-bundles-in-sharepoint-framework-160170171-on-windows)

## yo @microsoft/sharepoint 実行時のエラー対応

#### 問題点

yo @microsoft/sharepoint を実行すると以下のエラーが発生します。
```
Error: EINVAL: invalid argument, open '/usr/app/spfx/node\_modules/node-sass/package.json'
at Object.fs.openSync (fs.js:646:18)
at Object.fs.readFileSync (fs.js:551:33)
at Object.Module.\_extensions..json (module.js:670:20)
at Module.load (module.js:566:32)
at tryModuleLoad (module.js:506:12)
at Function.Module.\_load (module.js:498:3)
at Module.require (module.js:597:17)
at require (internal/module.js:11:18)
at Object. (/usr/app/spfx/node\_modules/node-sass/lib/extensions.js:7:9)
at Module.\_compile (module.js:653:30)
```

#### 対策

yo で使用するパッケージマネージャを yarn に変更してください。
具体的には、yo @microsoft/sharepoint  の代わりに yo @microsoft/sharepoint --package-manager yarn  を実行してください。
参考：<https://github.com/waldekmastykarz/docker-spfx/issues/19>

## Local workbench を開く際に発生する「このページを表示できません」エラーの対応

#### 問題点

Local workbench を開こうとすると「このページを表示できません」エラー(INET\_E\_RESOURCE\_NOT\_FOUND)が発生し、Local workbench が開けません。

#### 対策

本記事の「github に記載の Known issues」に記載の対応を行ってください。

## Local workbench が真っ白問題の対応

#### 問題点

Local workbench を開くと Web パーツを追加するためのプラスマークのボタンなどが表示されず、Web パーツの追加ができません。

#### 対策

IE 11 だとこの問題が起きるようです。Chrome で開くようにしてください。

## Hosted workbench で Web パーツを追加しようとすると消えてしまう問題の対応

#### 問題点

Hosted workbench を開いて Web パーツを追加するためにプラスマークを押すと、Web パーツを追加する領域が消えて操作ができなくなります。

#### 対策

Hosted workbench 用に指定している SharePoint サイトの言語を「英語」にしてください。
第二言語だとダメなので、「英語」を指定してサイトを作成する必要があります。
 
私はこれらの対応を行うことで、v1.7.0、1.7.1 の docker-spfx で無事開発環境を構築することができました。
環境構築で行き詰った方、参考にしてみてください。
[AdSense-B]
