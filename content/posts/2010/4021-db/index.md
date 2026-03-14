---
title: "指定のコンテンツDBに属するサイトコレクションを一覧表示する"
description: "PowerShellを使って、指定のコンテンツDBに属するサイトコレクションの一覧を取得する方法です。"
date: 2010-03-14T02:29:50+09:00
slug: "4021-db"
categories: ["SharePoint 2010", "インストールと設定、管理"]
aliases: ["/article/4021/"]
draft: false
---
PowerShellを使って、指定のコンテンツDBに属するサイトコレクションの一覧を取得する方法です。

```
1: #サイトコレクションの一覧を表示したいコンテンツDBのIDを取得
```
```
2: #赤太字が対象コンテンツDBのID
```
```
3: PS C:UsersAdministrator.SP2010RCENT> get-spcontentdatabase
```
```
4:  
```
```
5: Id : 5e26bcb9-680d-4292-bb45-07474e848348
```
```
6: Name : WSS\_Content
```
```
7: WebApplication : SPWebApplication Name=SharePoint - 80
```
```
8: Server : sp2010rcent
```
```
9: CurrentSiteCount : 2
```
```
10:  
```
```
11: Id : 1879f902-66a2-4147-92ef-6d61d05cf77d
```
```
12: Name : WSS\_Content\_Docs
```
```
13: WebApplication : SPWebApplication Name=SharePoint - 80
```
```
14: Server : sp2010rcent
```
```
15: CurrentSiteCount : 1
```
```
16:  
```
```
17: Id : 1ead42e7-856c-4b68-b75e-675c387130f5
```
```
18: Name : WSS\_Content\_Workspaces
```
```
19: WebApplication : SPWebApplication Name=SharePoint - 80
```
```
20: Server : sp2010rcent
```
```
21: CurrentSiteCount : 1
```
```
22:  
```
```
23: Id : 1fb9798e-c5bd-485d-8ff3-87d95a84c5cf
```
```
24: Name : WSS\_Content\_Media
```
```
25: WebApplication : SPWebApplication Name=SharePoint - 80
```
```
26: Server : sp2010rcent
```
```
27: CurrentSiteCount : 1
```
```
28:  
```
```
29: #先ほど取得したIDをパラメータに指定
```
```
30: #サイトコレクションの一覧を取得する
```
```
31: PS C:UsersAdministrator.SP2010RCENT> get-spsite -contentdatabase 5e26bcb9-680d-4292-bb45-07474e848348
```
```
32:  
```
```
33: Url
```
```
34: ---
```
```
35: http://sp2010rcent
```
```
36: http://sp2010rcent/my
```
