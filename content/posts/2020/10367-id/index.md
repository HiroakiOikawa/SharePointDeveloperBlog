---
title: "リストの種類を表す「リストテンプレート ID」"
description: "SharePoint Framework 拡張機能のコマンドセットを開発する際に指定する RegistrationId 属性の値に指定するリストテンプレート ID について説明します。"
date: 2020-09-19T13:08:01+09:00
slug: "10367-id"
categories: ["Office 365", "SharePoint", "開発とプログラミング"]
tags: ["CommandSet", "ListTemplateId", "M365Dev", "SharePoint", "SPFx"]
aliases: ["/article/10367/"]
draft: false
---
# はじめに

SharePoint Framework 拡張機能のコマンドセットを開発する際に、どのリストにカスタムアクションを紐づけるのかを elements.xml の RegistrationId 属性で指定します。
RegistrationId にはリストテンプレート ID を指定するのですが、このリストテンプレート ID とはいったい何者なのか、SharePoint オンプレ時代から SharePoint に関わっていない限り何だかよく分からないと思うので、この記事で簡単に解説します。

# リストテンプレート ID とは

リストテンプレート ID は、SharePoint のリストの種類ごとに割り当てられた ID です。
この ID を見ることで、リストがどのテンプレートから作成されたのかを識別することができます。
既存リストの リストテンプレート ID は、プログラムを通じて確認することが可能です。
PowerShell の場合、以下のようなコードで確認できます。
```
$url = "サイトのURL"
$account = "アカウント名"
$listName = "リスト/ライブラリ名"
$password = Read-Host -Prompt "Enter Your Password." -AsSecureString
$credential = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($account, $password)
$context = New-Object Microsoft.SharePoint.Client.ClientContext($url)
$context.Credentials = $credential
$list = $context.Web.Lists.GetByTitle($listName)
$context.Load($list)
$context.ExecuteQuery()
Write-Host "List BaseTemplate : " $list.BaseTemplate
```

# リストテンプレート ID の一覧

SharePoint 標準リストのリストテンプレート ID の一覧は、docs に掲載されています。
[ListTemplateType enumeration](https://docs.microsoft.com/en-us/previous-versions/office/sharepoint-server/ee541191(v=office.15)?WT.mc_id=M365-MVP-4012897)
ただ、これを見ても分かりづらいと思うので、以下の日本語ドキュメントを見るのが良いと思います。
でもこのページはリストテンプレート ID の説明をしているページではないため、リストテンプレート ID の説明はページ後半の「型」の説明文章として記載されています。
[List 要素 (リスト)](https://docs.microsoft.com/ja-jp/sharepoint/dev/schema/list-element-list#elements-and-attributes?WT.mc_id=M365-MVP-4012897)
ということで、以下に該当箇所を抜き出しておきます。
今後追加されている可能性もあるので、最新情報は docs を見るようにしてください。

|  |  |
| --- | --- |
| リストテンプレートID | リストテンプレート名 |
| 100 | 汎用リスト |
| 101 | ドキュメントライブラリ |
| 102 | アンケート |
| 103 | リンクリスト |
| 104 | アナウンスリスト |
| 105 | 連絡先リスト |
| 106 | Events リスト |
| 107 | タスクリスト |
| 108 | ディスカッション掲示板 |
| 109 | 画像ライブラリ |
| 110 | データソース |
| 111 | サイトテンプレートギャラリー |
| 112 | ユーザー情報リスト |
| 113 | Web パーツギャラリー |
| 114 | リストテンプレートギャラリー |
| 115 | XML フォームライブラリ |
| 116 | マスターページギャラリー |
| 117 | コードなしのワークフロー |
| 118 | カスタムワークフロープロセス |
| 119 | Wiki ページライブラリ |
| 120 | リストのカスタムグリッド |
| 130 | データ接続ライブラリ |
| 140 | ワークフロー履歴 |
| 150 | ガントタスクリスト |
| 200 | 会議のシリーズリスト |
| 201 | 会議の議題リスト |
| 202 | 会議出席者リスト |
| 204 | 会議の決定リスト |
| 207 | 会議の目的リスト |
| 210 | 会議テキストボックス |
| 211 | 会議のアイテムの一覧を表示する |
| 212 | 会議ワークスペースページリスト |
| 301 | ブログ投稿リスト |
| 302 | ブログのコメントリスト |
| 303 | ブログカテゴリリスト |
| 1100 | 問題の追跡 |
| 1200 | 管理者タスクリスト |

 
[AdSense-B]
