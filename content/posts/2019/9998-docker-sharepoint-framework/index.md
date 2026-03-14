---
title: "Docker を使った SharePoint Framework 開発環境の構築 その３"
description: "はじめに ※2020年2月2日更新 Docker 上に SharePoint Framework の開発環境を構築する手順をまとめました。 この資料の内容は、 こちらのスライド からの抜粋となります。 構築手順をまとめて確認したい方は、スラ…"
date: 2019-12-08T16:04:01+09:00
slug: "9998-docker-sharepoint-framework"
categories: ["Office 365", "SharePoint", "開発とプログラミング"]
tags: ["Docker", "Office 365", "OfficeDev", "SharePoint", "SharePoint Framework", "SPFx", "構築", "開発環境"]
aliases: ["/article/9998/"]
draft: false
---
# はじめに

※2020年2月2日更新
Docker 上に SharePoint Framework の開発環境を構築する手順をまとめました。
この資料の内容は、[こちらのスライド](https://www.slideshare.net/HiroakiOikawa/sharepoint-framework-teams)からの抜粋となります。
構築手順をまとめて確認したい方は、スライドをダウンロードしてください。
なお、環境構築手順は、
・[開発環境を構築するためにホストとなる PC で行う手順](http://sharepoint.orivers.jp/?p=9954)
・[Docker イメージを準備する手順](http://sharepoint.orivers.jp/?p=9965)
・[Docker 上でプロジェクトごとに行う手順](http://sharepoint.orivers.jp/?p=9998)
の３部構成になっています。
この記事では、Docker 上でプロジェクトごとに行う手順について記載します。

# Docker 上でプロジェクトごとに行う手順

## プロジェクトフォルダの作成

Docker で Shared Drive として指定したドライブに、SharePoint Framework 開発用の作業フォルダを作成し、その作業フォルダの下にプロジェクト用のフォルダを作成します。

## Docker コンテナの起動

開発環境として使用する Docker コンテナを起動するため、PowerShell で以下のコマンドを実行します。
```
docker run -it --rm --name [プロジェクト名] -v [プロジェクトフォルダ]:/usr/app/spfx -p 4321:4321 -p 5432:5432 -p 35729:35729 [イメージ名]
```
以下、実行コマンドの例です。
```
docker run -it --rm --name SampleProject -v C:\work:/usr/app/spfx -p 4321:4321 -p 5432:5432 -p 35729:35729 orivers/spfx:1.9.1
```

## 各種モジュールのインストール

Docker コンソールにて、以下のコマンドを実行して必要なモジュールをインストールします。
なお、こちらの手順は、Docker イメージを waldekm さんの Docker Hub から取得した場合のみ行ってください。
私が作成したイメージ及び Dockerfile は、こちらのインストールが済んだ状態になっているので実行不要です。
```
npm install gulp
```

## プロジェクトの作成

続いて、以下のコマンドを実行してプロジェクトを作成します。
yo コマンドを実行すると色々と質問が表示され、それに回答していくとプロジェクトが作成されます。
Web パーツ開発、拡張機能開発により、質問への回答の仕方が異なってくるのですが、その辺りは別記事で紹介したいと思います。
```
yo @microsoft/sharepoint --package-manager yarn
```
なお、このコマンドを実行すると SharePoint Framework 開発に必要な各種ソースコードや設定ファイルがダウンロードされるのですが、この際に環境によってはエラーが発生する可能性があります。
一部ではありますが、エラーが発生した場合の対応や、追加で行わなければならない設定などを別記事でまとめているので、行き詰った方は参考にしてください。
・[Docker で SharePoint Framework 開発環境を構築する際の注意事項](http://sharepoint.orivers.jp/article/9902)
・[SharePoint Framework v1.7.0, v1.7.1 Docker image 使用時の注意点](http://sharepoint.orivers.jp/article/9914)

## 各種 json の変更と SPWebBuildRig.js の修正

yo コマンドで作成されたファイルを一部変更する必要があります。
変更内容は [waldekmastykarz さんの github](https://github.com/waldekmastykarz/docker-spfx) にも記載がありますが、当然のことながら英語表記なので、ここでは日本語で書いておきます。

### ① デバッグ用 SharePoint Online サイトの指定

VSCode で、${PWD}/.vscode/launch.json を開き、以下の通り修正します。

- 11 行目の「https://localhost:4321/temp/workbench.html」を以下の URL に変更する。
  https://localhost:5432/workbench
- 28 行目の「enter-your-SharePoint-site」の個所にデバッグで使用する SPO サイトの URL を入力する。

変更後の launch.json は以下のようになります。
※ 例として、28 行目は「orivers.sharepoint.com/sites/modern-ui」を指定しています。
```
"version": "0.2.0",
"configurations": [{
"name": "Local workbench",
"type": "chrome",
"request": "launch",
"url": "https://localhost:5432/workbench",
"webRoot": "${workspaceRoot}",
"sourceMaps": true,
```
```
{
"name": "Hosted workbench",
"type": "chrome",
"request": "launch",
"url": "https://orivers.sharepoint.com/sites/modern-ui/\_layouts/workbench.aspx",
"webRoot": "${workspaceRoot}",
"sourceMaps": true,
```

### ② workbench のエラー対応 - serve.json の修正

VSCode で ${PWD}/config/serve.json を開き、以下の通り修正します。

- 4 行目に以下の行を追加する。
  "hostname": "0.0.0.0",

```
{
"$schema": "https://developer.microsoft.com/json-schemas/core-build/serve.schema.json",
"port": 4321,
"hostname": "0.0.0.0",
"https": true,
"initialPage": "https://localhost:5432/workbench",
"api": {
"port": 5432,
"entryPath": "node\_modules/@microsoft/sp-webpart-workbench/lib/api/"
}
}
```

### ③ workbench のエラー対応 - write-manifests.json の修正

VSCode で ${PWD}/config/write-manifests.json を開き、以下の通り修正します。

- 3 行目の最後に「,」を追加する。
- 4 行目に以下の行を追加する。
  "debugBasePath": "https://localhost:4321/"

```
{
"$schema": "https://developer.microsoft.com/json-schemas/spfx-build/write-manifests.schema.json",
"cdnBasePath": "<!-- PATH TO CDN -->",
"debugBasePath": "https://localhost:4321/"
}
```

### ④ workbench のエラー対応 - SPWebBuildRig.js の修正

VSCode で ${PWD}/node\_modules/@microsoft/sp-build-web/lib/SPWebBuildRig.js を開き、以下の通り修正します。

- finalizeSharedConfig() ファンクション内の debugBasePath をセットする処理を debugBasePath が 空の場合にのみセットするよう、if 分を追加する。
  ※ SPFx v1.10 の場合は 96～98行目、SPFx v1.9.1 の場合は 92 ～ 94 行目

修正前：
```
spBuildCoreTasks.writeManifests.mergeConfig({
debugBasePath: `${serve.taskConfig.https ? 'https' : 'http'}://${serve.taskConfig.hostname}:${serve.taskConfig.port}/`
});
```
修正後：
```
if (!spBuildCoreTasks.writeManifests.taskConfig.debugBasePath) {
spBuildCoreTasks.writeManifests.mergeConfig({
debugBasePath: `${serve.taskConfig.https ? 'https' : 'http'}://${serve.taskConfig.hostname}:${serve.taskConfig.port}/`
});
}
```

## 開発証明書の作成、インストール

続いて、以下のコマンドを実行して開発用証明書を作成します。
```
gulp trust-dev-cert
gulp serve
```
コマンド実行後、開発サーバーが起動するので、ローカル PC の Internet Explorer で https://localhost:5432/workbench  を開いて、証明書をインポートします。
証明書のインポート先には「信頼されたルート証明機関」を指定してください。
なお、証明書のインポートは実施しなくても特に大きな支障はありません。
 
以上で、プロジェクトごとに行う環境構築は完了です。
この後また別記事で、Web パーツなどプロジェクトの種類ごとに開発方法などを掲載していきたいと思います。
慣れればそうでもないのですが最初は大変な作業だと思いますので、何度か繰り返して体を慣らして、SharePoint Framework ライフを楽しみましょう！
[AdSense-B]
