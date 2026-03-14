---
title: "SharePoint Framework Web パーツ開発 その１：プロジェクトの作成"
description: "SharePoint Framework 開発における Web パーツの開発手順を説明します。開発環境は Docker の利用を想定していますが、大部分は Docker を使っていない環境でも同じです。"
date: 2020-02-03T09:30:02+09:00
slug: "10111-sharepoint-framework-web"
categories: ["Office 365", "SharePoint", "開発とプログラミング"]
tags: ["SharePoint", "SPFx", "Webパーツ", "yo sharepoint"]
aliases: ["/article/10111/"]
draft: false
---
# はじめに

SharePoint Framework による Web パーツの開発手順を説明します。
説明の題材として、SharePoint リストから URL 列の値を取得して一覧で表示する、クラシック UI でいうところのリンクリストのような Web パーツを開発していきたいと思います。
事前に Docker による SharePoint Framework 開発環境が準備できているところからの話になりますので、環境がない方は、まずは以下の記事を見て環境構築をしてください。
・[開発環境を構築するためにホストとなる PC で行う手順](http://sharepoint.orivers.jp/?p=9954)
・[Docker イメージを準備する手順](http://sharepoint.orivers.jp/?p=9965)

# プロジェクト作成手順

## プロジェクトフォルダの作成

Windows エクスプローラーで任意のフォルダにプロジェクトファイルを格納するためのプロジェクトフォルダを作成します。
ここでは、以下の場所にプロジェクトフォルダを作成します。
リンクリストの Web パーツを作るということで「LinkListWebPart」にしました。
```
D:\Users\Hiroaki Oikawa\Documents\Workspace\LinkListWebPart
```

## Visual Studio Code 起動

Visual Studio Code を起動してメニューから ファイル > フォルダーを開く をクリックし、プロジェクトフォルダを開きます。
続いて、メニューから 表示 > ターミナル をクリックし、PowerShell のターミナルを開きます。

## Docker 起動

ターミナルに、 Docker を起動するためのコマンドを入力し実行します。
```
docker run -it --rm --name LinkListWebPart -v ${PWD}:/usr/app/spfx -p 4321:4321 -p 5432:5432 -p 35729:35729 orivers/spfx
```
無事、Docker が起動すると、以下のような表示になります。
```
spfx@1aff9c9c9d11:/usr/app/spfx$
```
以後、上記のプロンプトにコマンドを入力していきます。

## プロジェクトの作成

yo コマンドで Web パーツのプロジェクトを作成します。
--package-manager yarn を指定しない場合、パッケージマネージャとしてはデフォルトの npm が使用されるのですが、これまで使っていて npm だとうまくいかないことが多かったので、私はいつも yarn を指定しています。
```
yo @microsoft/sharepoint --package-manager yarn
```
上記コマンドを実行すると、プロジェクト作成に必要な情報を入力するための質問が順に表示されます。
順に説明していきます。

### ① 統計情報収集への許可

```
? ==========================================================================
We're constantly looking for ways to make yo better!
May we anonymously report usage statistics to improve the tool over time?
More info: https://github.com/yeoman/insight & http://yeoman.io
==========================================================================
```
まずは統計情報の収集に対して許可を求められるので、ここは「y」を入力して品質向上に貢献しましょう。
このあと、いわゆる「yo おじさん」が登場します。
```
\_-----\_
| | .--------------------------.
|--(o)--| | Welcome to the |
`---------´ | SharePoint Client-side |
( \_´U`\_ ) | Solution Generator |
/\_\_\_A\_\_\_\ '--------------------------'
| ~ |
\_\_'.\_\_\_.'\_\_
´ ` |° ´ Y `
The yarn package manager will be used.
Let's create a new SharePoint solution.
```

### ② ソリューションの名前の指定

```
? What is your solution name?
```
ソリューション名を入力してください。
ここで指定した名前があらゆるところで使われるようになります。
今回は「LinkListWebPart」と入力しました。

### ③ デプロイ先 SharePoint のバージョンの指定

```
? Which baseline packages do you want to target for your component(s)? (Use arrow keys)
❯ SharePoint Online only (latest)
SharePoint 2016 onwards, including 2019 and SharePoint Online
SharePoint 2019 onwards, including SharePoint Online
```
デプロイ先の SharePoint を選びます。
今回は Online 用に作るので、一番上の「SharePoint Online only (latest)」を選択しました。
ちなみに、オンプレバージョンを選ぶと、オンプレのバージョンに合わせた SharePoint Framework のバージョンが自動的に選択されるので、最新の SharePoint Framework の機能を利用することはできなくなります。

### ④ 作業フォルダの指定

```
? Where do you want to place the files? (Use arrow keys)
❯ Use the current folder
Create a subfolder with solution name
```
VSCode で開いているフォルダ（カレントフォルダ）を指定するか、サブフォルダを作るかを指定します。
この記事の流れで進めると、この段階で Web パーツ用のフォルダがカレントフォルダの状態なので、「Use the current folder」を選択します。

### ⑤ 全サイトへの自動展開の指定

```
? Do you want to allow the tenant admin the choice of being able to deploy the solution to all sites immediately without running any feature deployment or adding apps in sites? (y/N)
```
これから開発する Web パーツをテナントにデプロイした際に、自動的にすべてのサイトで展開されるようにするか否かを指定します。
任意のサイトで必要に応じて展開したいので、ここでは「n」を指定します。

### ⑥ 分離ドメインでの実行の指定

```
? Will the components in the solution require permissions to access web APIs that are unique and not shared with other components in the tenant? (y/N)
```
Web パーツを iFrame として作成し、Web パーツを配置するコンテキストとは別のコンテキストでどうさせるようにするか否かを指定します。
今回は配置したページにあるリンクリストを参照したいので、「n」を指定します。

### ⑦ 開発するコンポーネントの種類の指定

```
? Which type of client-side component to create? (Use arrow keys)
❯ WebPart
Extension
Library
```
開発するコンポーネントの種類を指定します。
今回は Web パーツを作るので、「WebPart」を選択します。

### ⑧ Web パーツ名の指定

```
? What is your Web part name?
```
Web パーツの名前を指定します。
後から変更できるので何でも OK です。
今回は「LinkListWebPart」にしました。

### ⑨ Web パーツの説明文の指定

```
? What is your Web part description?
```
Web パーツの説明文を指定します。
後から変更できるので何でも OK です。
今回は「LinkList」にしました。

### ⑩ JavaScript Framework の指定

```
? Which framework would you like to use?
No JavaScript framework
❯ React
Knockout
```
Web パーツのレンダリングに使う JavaScript Framework を指定します。
今回は「React」を指定します。
React は SharePoint Framework で標準的に使われているフレームワークで、ネットで検索すると情報も多く出てくるので始めやすいのではないかと思います。
 
ここまで入力を進めて、Enter キーを押すと、指定した内容に基づいて様々なパッケージがダウンロード＆インストールされて、プロジェクトに必要なファイルが一式用意されます。
ネット環境にもよりますが数分は掛かります。
なお、出来上がったプロジェクトの全ファイル容量を確認すると、最初は空だった作業フォルダに 700MB 程度のファイルが格納されています。
これらのファイルのほぼすべてをネットからダウンロードしてくるので、プロジェクト作成時はネットワーク環境がとても大事です。
完了すると、Congratulations!って表示されます。
これでひとまずプロジェクトの作成は完了です。
```
###########| .-------------------------------------------.
###/ (##|(@) | Congratulations! |
### ######| \ | Solution link-list-web-part is created. |
###/ /###| (@) | Run gulp serve to play with it! |
####### ##| / '-------------------------------------------'
### /##|(@)
###########|
\*\*=+####!
```
 
これでプロジェクトは作成されましたが、実際にコーディングやデバッグに入る前に、いくつかのファイルを変更しないといけない部分があります。

## コーディングに入る前の事前準備

事前準備については別記事「[Docker を使った SharePoint Framework 開発環境の構築 その３](https://sharepoint.orivers.jp/article/9998)」にまとめてあります。
上記記事の以下の 2 セクションを参考に事前準備作業を行ってください。

- 各種 json の変更と SPWebBuildRig.js の修正
- 開発証明書の作成、インストール

# まとめ

ここまでの作業で、無事 SharePoint Framework の Web パーツ開発のプロジェクトが作成できて、実行できる直前のところまできました。
次の記事ではデバッグ実行の方法について記載します。
 
[AdSense-B]
