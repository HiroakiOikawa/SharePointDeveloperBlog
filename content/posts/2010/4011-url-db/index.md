---
title: "指定のURL以下のサイトコレクションが属するコンテンツDBを取得する"
description: "PowerShellを使って、指定のURL以下のサイトコレクションが属するコンテンツDBを取得する方法です。"
date: 2010-03-14T02:28:14+09:00
slug: "4011-url-db"
categories: ["SharePoint 2010", "インストールと設定、管理"]
aliases: ["/article/4011/"]
draft: false
---
PowerShellを使って、指定のURL以下のサイトコレクションが属するコンテンツDBを取得する方法です。

```
1: #最初のパラメータにURLを指定。
```
```
2: #ワイルドカード指定可能。
```
```
3: PS C:UsersAdministrator.SP2010RCENT> get-spsite http://sp2010rcent/\* | select url, contentdatabase | format-list
```
```
4:  
```
```
5: Url : http://sp2010rcent
```
```
6: ContentDatabase : SPContentDatabase Name=WSS\_Content
```
```
7:  
```
```
8: Url : http://sp2010rcent/my
```
```
9: ContentDatabase : SPContentDatabase Name=WSS\_Content
```
```
10:  
```
```
11: Url : http://sp2010rcent/docs
```
```
12: ContentDatabase : SPContentDatabase Name=WSS\_Content\_Docs
```
```
13:  
```
```
14: Url : http://sp2010rcent/media
```
```
15: ContentDatabase : SPContentDatabase Name=WSS\_Content\_Workspaces
```
```
16:  
```
```
17: Url : http://sp2010rcent/workspaces
```
```
18: ContentDatabase : SPContentDatabase Name=WSS\_Content\_Media
```
