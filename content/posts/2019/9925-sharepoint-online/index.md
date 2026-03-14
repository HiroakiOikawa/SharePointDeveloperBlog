---
title: "SharePoint Online ページ診断ツール"
description: "はじめに マイクロソフト純正の SharePoint Online 用ページ診断ツール「Page Diagnostics for SharePoint」が、google chrome 拡張機能としてリリースされています。 このツールを使って…"
date: 2019-02-02T10:43:54+09:00
slug: "9925-sharepoint-online"
categories: ["Office 365", "SharePoint", "全般"]
tags: ["Diagnostics", "SharePoint", "ツール", "診断"]
aliases: ["/article/9925/"]
draft: false
---
# はじめに

マイクロソフト純正の SharePoint Online 用ページ診断ツール「Page Diagnostics for SharePoint」が、google chrome 拡張機能としてリリースされています。
このツールを使ってどんな診断ができるのか試してみました。

# Page Diagnostics for SharePoint の入手とインストール

chrome ウェブストアで「SharePoint」で検索すると出てきます。
<https://chrome.google.com/webstore/search/sharepoint?hl=ja>
[![](./spodig1-300x77.png)](http://sharepoint.orivers.jp/wp-content/uploads/2019/01/spodig1.png)
[Chromeに追加]ボタンをクリックすると、確認メッセージが表示されるので[拡張機能を追加]をクリックします。
[![](./spodig2-300x162.png)](http://sharepoint.orivers.jp/wp-content/uploads/2019/01/spodig2.png)
インストールするとブラウザの右上に拡張機能のボタンが追加されます(下図赤枠部分)
[![](./spodig3.png)](http://sharepoint.orivers.jp/wp-content/uploads/2019/01/spodig3.png)

# 使い方と診断内容

使い方はとっても簡単。
チェックしたいページを開いた後、ツールバーから診断ツールを起動させて、[Start]ボタンをクリックするだけ。
[![](./spodig4-250x300.png)](http://sharepoint.orivers.jp/wp-content/uploads/2019/01/spodig4.png)
 
すると、診断が開始されて、結果がすぐに表示されます。
[![](./spodig5-281x300.png)](http://sharepoint.orivers.jp/wp-content/uploads/2019/01/spodig5.png)
[![](./spodig6-300x124.png)](http://sharepoint.orivers.jp/wp-content/uploads/2019/01/spodig6.png)
結果が OK のところは緑のチェック、NG のところは赤のチェックが表示され、文字の部分をクリックすると NG の場合には NG の理由、改善策が英語で表示されます。
今回試しにすべてのチェックが NG になるようにして、どんな説明が表示されるのかを調べてみました。
Check Running as Standard  User
[![](./spodig7-300x110.png)](http://sharepoint.orivers.jp/wp-content/uploads/2019/01/spodig7.png)
Check Requests To SharePoint
[![](./spodig8-300x172.png)](http://sharepoint.orivers.jp/wp-content/uploads/2019/01/spodig8.png)
Check using CDN
[![](./spodig9-300x208.png)](http://sharepoint.orivers.jp/wp-content/uploads/2019/01/spodig9.png)
Check for Large Image Sizes
[![](./spodig10-300x161.png)](http://sharepoint.orivers.jp/wp-content/uploads/2019/01/spodig10.png)
Check for Structural Navigation
[![](./spodig11-300x98.png)](http://sharepoint.orivers.jp/wp-content/uploads/2019/01/spodig11.png)
Check for CBQ WebPart
[![](./spodig12-300x109.png)](http://sharepoint.orivers.jp/wp-content/uploads/2019/01/spodig12.png)

# ちょっと試してみた

試しに以下二つの実験をしてみました。
実験１：
SharePoint のページライブラリに自分でコーディングした HTML ファイルの拡張子を aspx にしたファイルをアップロード。
このファイルの診断ができるかどうかをチェック。
結果は以下の通り、SharePoint ページではないと診断されチェックできませんでした。
[![](./spodig14-300x73.png)](http://sharepoint.orivers.jp/wp-content/uploads/2019/01/spodig14.png)
実験２：
モダンページを診断できるかどうかをチェック。
結果は以下の通り、モダンページには対応していないとのこと。
[![](./spodig15-300x75.png)](http://sharepoint.orivers.jp/wp-content/uploads/2019/01/spodig15.png)
 
今のところ、クラシック UI の診断しかできませんが、SPO のパフォーマンスが気になった場合は試してみると何か発見があるかもしれません。
 
[AdSense-B]
