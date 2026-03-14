---
title: "SharePoint REST サンプル集"
description: "SharePoint Online や、オンプレ SharePoint で使える、SharePoint REST のサンプル集です。"
date: 2020-01-26T10:27:37+09:00
slug: "10097-sharepoint-rest"
categories: ["Office 365", "SharePoint 2013", "SharePoint 2016", "開発とプログラミング"]
tags: ["REST", "SharePoint", "サンプル"]
aliases: ["/article/10097/"]
draft: false
---
最終更新日：2020/09/22

# はじめに

SharePoint オンプレ、オンラインで使える REST のサンプルを思いついた時にメモ代わりにこの記事へ記載していきます。
SharePoint REST の文法の詳細については、[Docs](https://docs.microsoft.com/ja-jp/sharepoint/dev/sp-add-ins/get-to-know-the-sharepoint-rest-service?WT.mc_id=M365-MVP-4012897) を参照してください。
バージョンは 2013 ですが、壁面に貼るリアルな壁紙もあったりするので、是非プロジェクトルームの目に付くところへどうぞｗ
[SharePoint 2013 REST Syntax](https://www.microsoft.com/en-in/download/details.aspx?id=41147)
また、対象が SharePoint Online であれば、SharePoint REST ではなく、Microsoft Graph REST API を使う方法もあります。
Graph REST API で SharePoint にアクセスする方法についても、[Docs](https://docs.microsoft.com/ja-jp/graph/api/resources/sharepoint?view=graph-rest-1.0&WT.mc_id=M365-MVP-4012897) に詳細の記載があるので参考にしてください。
SharePoint REST を使用するか、Graph REST API を使用するかの線引きは、SharePoint にアクセス可能なアクセストークンを既に持っているかどうか。
例えば、SharePoint ページに配置されるスクリプト内から Call するのであれば、SharePoint REST API を使う方が簡単です。
このサンプル集では、SharePoint REST API を取り扱います。

# リスト、ライブラリのアイテム取得関連

■ すべてのアイテム 100 件
https://[サイトの URL]/\_api/web/lists/getbytitle('[リストのタイトル]')/items
■ すべてのアイテム 5000 件
https://[サイトの URL]/\_api/web/lists/getbytitle('[リストのタイトル]')/items?$top=5000
■ すべてのアイテムの ID 降順で 5000 件
https://[サイトの URL]/\_api/web/lists/getbytitle('[リストのタイトル]')/items?$orderby=ID desc&$top=5000
■ 更新日付が 2020/01/01 以降の直近 5 件（更新日付降順で  5 件）のアイテム
https://[サイトの URL]/\_api/web/lists/getbytitle('[リストのタイトル]')/items?$filter=Modified ge '2020-01-01'&$orderby=Modified desc&$top=5
■ 更新日付が 2020/01/01 ～ 2020/01/31 のアイテムの更新日付昇順
https://[サイトの URL]/\_api/web/lists/getbytitle('[リストのタイトル]')/items?$filter=Modified ge '2020-01-01' and Modified le '2020-01-31'&$orderby=Modified
■ ユーザーとグループの列(例として内部名「ADUser」の列)の値から名前とメールアドレスを取得する
https://[サイトの URL]/\_api/web/lists/getbytitle('[リストのタイトル]')/items?$select=ADUser/Title,ADUser/EMail&$expand=ADUser
■ 特定のアイテムの添付ファイルの一覧
https://[サイトの URL]/\_api/web/lists/getbytitle('[リストのタイトル]')/items([対象リストアイテムのID])/AttachmentFiles
■ リスト ID を指定したリストのすべてのアイテム100件取得その１
https://[サイトの URL]/\_api/web/lists/getbyid('[リストID]')/items
■ リスト ID を指定したリストのすべてのアイテム100件取得その２
https://[サイトの URL]/\_api/web/lists(guid'[リストID]')/items

# サイトコレクション設定関連

■ サイトコレクションの設定
https://[サイトコレクションの URL]/\_api/site/
■ サイトコレクションでアクティブにしている機能の一覧
https://[サイトコレクションの URL]/\_api/site/features?$select=definitionid,displayname
■ サイトコレクションのアプリカタログの存在チェック
https://[サイトコレクションの URL]/\_api/site/rootweb/sitecollectionappcatalog
■ サイトコレクションのアプリカタログに登録されているアプリの一覧
https://[サイトコレクションの URL]/\_api/site/rootweb/sitecollectionappcatalog/availableapps

# サイト設定関連

■ サイトの設定
https://[サイトの URL]/\_api/web/
■ サイト内のサブサイト一覧
https://[サイトの URL]/\_api/web/webs
■ サイト内のリスト一覧
https://[サイトの URL]/\_api/web/lists
■ サイト内のリストのアイテム数の一覧
https://[サイトの URL]/\_api/web/lists?$select=Title,ItemCount
■ サイトでアクティブにしている機能の一覧
https://[サイトの URL]/\_api/web/features?$select=definitionid,displayname
■ サイトのサイドリンクバーの一覧
https://[サイトの URL]/\_api/web/Navigation/QuickLaunch?$expand=Children

# ユーザー、SharePoint グループ関連

■ カレントユーザーの表示名やメールアドレスなどの情報
https://[サイトの URL]/\_api/web/currentuser
■ サイト内の SharePoint グループ一覧
https://[サイトの URL]/\_api/web/sitegroups
■ サイト内のユーザーの一覧
https://[サイトの URL]/\_api/web/siteusers
■ SharePoint グループに属するユーザーの一覧
https://[サイトの URL]/\_api/web/sitegroups?$expand=Users

# リスト、ライブラリ設定関連

■ リストの設定
https://[サイトの URL]/\_api/web/lists/getbytitle('[リストのタイトル]')
■ リストの列の設定
https://[サイトの URL]/\_api/web/lists/getbytitle('[リストのタイトル]')/fields
■ リストのビューの設定
https://[サイトの URL]/\_api/web/lists/getbytitle('[リストのタイトル]')/Views
■ カスタム列(追加した列)の一覧
https://[サイトの URL]/\_api/web/lists/getbytitle('[リストのタイトル]')/fields?$filter=Hidden eq false and ReadOnlyField eq false
[AdSense-B]
