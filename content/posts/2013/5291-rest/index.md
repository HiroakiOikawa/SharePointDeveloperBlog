---
title: "REST サービスでサイト、リスト、アイテムを取得する"
description: "はじめに 今回は REST サービスを使ってサイト、リスト、アイテムのプロパティを取得する方法を説明します。 ここで説明する内容はブラウザと SharePoint があればすぐに試せるので、実際に動かしながら読んでみてください。 なお、RE…"
date: 2013-05-23T01:06:39+09:00
slug: "5291-rest"
categories: ["Office 365", "SharePoint 2013", "開発とプログラミング"]
aliases: ["/article/5291/"]
draft: false
---
## はじめに

今回は REST サービスを使ってサイト、リスト、アイテムのプロパティを取得する方法を説明します。
ここで説明する内容はブラウザと SharePoint があればすぐに試せるので、実際に動かしながら読んでみてください。
なお、REST サービスから返ってくる XML の読み方は[前回](http://sharepoint.orivers.jp/article/5121)説明していますので、そちらを参照してください。

## サイトのプロパティを取得する

まずは REST を使って任意のサイトのプロパティを取得する方法です。
```
http://site url/\_api/web
```
※「site url」には、プロパティを取得したいサイトの URL を入れてください。
 
例：adslearn サイトのプロパティを取得する。
```
https://adslearn.sharepoint.com/\_api/web/
```
 
例：adslearn サイトの photocontest というサブサイトのプロパティを取得する。
```
https://adslearn.sharepoint.com/photocontest/\_api/web
```
 
サイトの特定のプロパティだけ取得したい場合には、先ほどの URL の後ろにプロパティ名をつなげます。
```
http://site url/\_api/web/property
```
※「property」には、取得したいプロパティの名前を入れます。
※指定できるプロパティの名前は、サイトのプロパティを取得する REST 呼び出しから返ってくる XML の property タグ及び link タグの値です。[前回の記事参照。](http://sharepoint.orivers.jp/article/5121)
 
例：adslearn サイトのタイトル (Title) を取得する。※括弧内はプロパティ名
```
https://adslearn.sharepoint.com/\_api/web/Title
```
 
例：adslearn サイトのリストの一覧 (Lists) を取得する。
```
https://adslearn.sharepoint.com/\_api/web/Lists/
```
 
例：adslearn サイトのユーザーの一覧 (SiteUsers) を取得する。
```
https://adslearn.sharepoint.com/\_api/web/SiteUsers
```

## 

## リストのプロパティを取得する

任意のリストのプロパティを取得したい場合は、GetByTitle という関数を使ってリスト指定します。
```
http://site url/\_api/web/lists/getbytitle('リスト名')
```
※「リスト名」にはリストの表示名を入れます。
 
例：adslearn サイトのタスクリストを取得する。
```
https://adslearn.sharepoint.com/\_api/web/lists/getbytitle('タスク')
```
 
リストの任意のプロパティだけを取得したい場合には、先ほどの URL の後ろにプロパティ名をつなげます。
```
http://site url/\_api/web/lists/getbytitle('リスト名')/property
```
※「property」には、取得したいプロパティの名前を入れます。
※指定できるプロパティの名前は、リストの情報を取得する REST 呼び出しから返ってくる XML の property タグ及び link タグの値です。[前回の記事参照。](http://sharepoint.orivers.jp/article/5121)
 
例：adslearn サイトのタスクリストのアイテム数(ItemCount)を取得する。 ※括弧内はプロパティ名
```
https://adslearn.sharepoint.com/\_api/web/lists/getbytitle('タスク')/itemcount
```
 
例：adslearn サイトのタスクリストのアイテムの最終更新日(LastItemModifiedDate)を取得する。
```
https://adslearn.sharepoint.com/\_api/web/lists/getbytitle('タスク')/lastitemmodifieddate
```
 
例：adslearn サイトのタスクリストの全アイテム(Items)を取得する。
```
https://adslearn.sharepoint.com/\_api/web/lists/getbytitle('タスク')/items
```

## 

## アイテムのプロパティを取得する

任意のリストアイテムのプロパティを取得したい場合には、いくつか指定の方法があります。
もっとも簡単なのは ID を指定するパターンです。
例：adslearn サイトのタスクリストの ID が 1 のアイテムを取得する。
```
https://adslearn.sharepoint.com/\_api/web/lists/getbytitle('タスク')/getitembyid(1)
```
 
列の値やプロパティの値が条件式に合致するアイテムを取得することもできます。
例：adslearn サイトのタスクリストのタイトル(Title)が"Task1"のアイテムを取得する。
```
https://adslearn.sharepoint.com/\_api/web/lists/getbytitle('タスク')/items?$filter=Title eq 'Task1'
```
その他、条件式には色々な指定ができるので、これについては改めて別記事で書きたいと思います。
また、特定のプロパティのみ抽出する方法や参照列の値を取得してくる方法など、値の取り方についても別記事で書きます。

## 

## まとめ

今回はサイト、リスト、アイテムのプロパティの取得方法について、詳細に説明しました。
REST URL の書き方は開発者にとってはとても自然な書き方だと思うので、ここに書いた内容をざっと読んでいただければ、あとはいくらでも応用ができるようになるかと思います。
次回はアイテムの取得の仕方について、クエリ演算子の話を中心に詳しく説明します。
