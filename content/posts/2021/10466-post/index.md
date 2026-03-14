---
title: "サイトテンプレートによるモダンサイトのテンプレート化とサイト作成 その３：既存サイトのテンプレート化"
description: "モダンサイトのサイトテンプレート機能により、サイトの構造をテンプレート化して横展開することが可能となります。今回は作成済みのサイトからサイトテンプレートを作成する方法を記載します。"
date: 2021-07-17T01:53:30+09:00
slug: "10466-post"
categories: ["Office 365", "コードスニペット"]
tags: ["SharePoint", "サイトスクリプト", "サイトデザイン", "サイトテンプレート"]
aliases: ["/article/10466/"]
draft: false
---
# はじめに

モダンサイトのサイトテンプレート機能により、サイトの構造をテンプレート化して横展開することが可能となります。
このサイトテンプレート機能の使い方を複数回に分けて紹介します。

- [サイトテンプレートとサイトスクリプト](https://sharepoint.orivers.jp/article/10416)
- [サイトテンプレートの作成と登録](https://sharepoint.orivers.jp/article/10434)
- 既存サイトのテンプレート化（本記事）

今回は作成済みのサイトからサイトテンプレートを作成する方法を記載します。

# 既存のサイトからサイトテンプレートを作成する方法

既存のサイトからサイトテンプレートを作成するには、まず初めにサイトスクリプトを作成します。
サイトスクリプトは PowerShell の「[Get-SPOSiteScriptFromWeb](https://docs.microsoft.com/ja-jp/powershell/module/sharepoint-online/Get-SPOSiteScriptFromWeb?view=sharepoint-ps&WT.mc_id=M365-MVP-4012897)」コマンドレットを使用することで、既存サイトから自動作成することができます。
```
Connect-SPOService -Url [SharePoint 管理センターの URL]
# サイトスクリプトファイルを自動作成
# IncludedListsパラメータにはサイトスクリプトに含めたいリストの URL を指定
$template = Get-SPOSiteScriptFromWeb `
-WebUrl [テンプレートサイトのURL] `
-IncludeBranding `
-IncludeTheme `
-IncludeRegionalSettings `
-IncludeSiteExternalSharingCapability `
-IncludeLinksToExportedItems `
-IncludedLists ("Shared Documents", "Lists/List", "SitePages")
$template | Out-File [サイトスクリプトファイルのフルパス.xml]
```
上記コマンドでサイトスクリプトを作成後、以下のコマンドでサイトテンプレートにサイトスクリプトを登録します。
```
# サイトスクリプトをテナントに登録
$content = Get-Content [サイトスクリプトファイルのフルパス] -Raw
$siteScript = Add-SPOSiteScript `
-Title [サイトスクリプトの名前] `
-Description [サイトスクリプトの説明文] `
-Content $content
# サイトテンプレートをテナントに登録
# WebTemplateは、サイトテンプレートを利用可能にする標準サイトテンプレートのサイトテンプレートID
Add-SPOSiteDesign `
-Title [サイトテンプレートの名前] `
-WebTemplate "64" `
-SiteScripts $siteScript.Id `
-Description [サイトテンプレートの説明文]
```
以上の手順により、既存サイトから作成したサイトテンプレートを利用できるようになります。

# Get-SPOSiteScriptFromWeb コマンドレットの制限

既存サイトからサイトテンプレートを作成できるのはとても便利なのですが、クラシックサイトにおけるサイトをサイトテンプレートとして保存する機能とは異なり、テンプレート化される範囲は非常に限定的です。
2021年7月時点では、以下の要素が既存サイトからサイトテンプレートを作成した場合にサイトテンプレートに含まれることとなります。

- サイトのブランド化の構成
- 指定したリストの設定
- ナビゲーションリンク
- 地域の設定
- 外部共有の設定
- カスタムテーマの設定

サイトテンプレートに含まれない主な要素としては以下のようなものがあります。

- ページに配置した Webパーツ の設定
- リスト/ライブラリ内のアイテム、ファイル
- アクセス権

 
クラシックサイトのサイトテンプレートよりも劣る部分については、今後のアップデートで拡充されていくと思うのでサイトテンプレートを使用する前には docs を確認することをお勧めします。
[AdSense-B]
