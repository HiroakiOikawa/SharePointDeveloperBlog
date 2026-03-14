---
title: "Microsoft 365 Virtual Marathon 2021 に登壇いたしました"
description: "Microsoft 365 Virtual Marathon 2021 で登壇した資料とサイトテンプレート、PnP リモートプロビジョニングの PowerShell コードを公開しました。"
date: 2021-04-27T19:09:10+09:00
slug: "10450-microsoft-365-virtual-marathon-2021"
categories: ["Office 365", "勉強会・イベントなど", "開発とプログラミング"]
tags: ["M365VM", "PnP", "SharePoint", "サイトテンプレート"]
aliases: ["/article/10450/"]
draft: false
---
2021年4月27日開催の Microsoft 365 Virtual Marathon 2021 に登壇いたしました。
セッションでは、SharePoint で必要不可欠なサイトテンプレートの機能について話をしました。
詳細は以下にセッションスライドをアップしておりますので、そちらをご確認ください。
 

**[Microsoft 365 Virtual Marathon 2021 - SharePoint サイトの自動作成あれこれ](//www.slideshare.net/HiroakiOikawa/microsoft-365-virtual-marathon-2021-sharepoint "Microsoft 365 Virtual Marathon 2021 - SharePoint サイトの自動作成あれこれ")**  from **[Hiroaki Oikawa](https://www.slideshare.net/HiroakiOikawa)**

 
また、セッションで使った PowerShell のコードについては以下に記載しておきます。
この内容については、さらに深堀していってブログにまとめて行きたいと思います。
ご参加いただいた皆様、ありがとうございました！
■サイトテンプレート作成
```
Connect-SPOService -Url [SharePoint 管理センターの URL]
# テンプレートファイルを自動作成
# IncludedListsパラメータにはテンプレートに含めたいリストの URL を指定
$template = Get-SPOSiteScriptFromWeb `
-WebUrl [テンプレートサイトのURL] `
-IncludeBranding `
-IncludeTheme `
-IncludeRegionalSettings `
-IncludeSiteExternalSharingCapability `
-IncludeLinksToExportedItems `
-IncludedLists ("Shared Documents", "Lists/List", "SitePages")
$template | Out-File [サイトテンプレートファイルのフルパス.xml]
```
■サイトテンプレート、サイトスクリプトの登録
```
# サイトスクリプトを登録
$content = Get-Content [テンプレートファイルのフルパス] -Raw
$siteScript = Add-SPOSiteScript `
-Title [サイトスクリプトの名前] `
-Description [サイトスクリプトの説明文] `
-Content $content
# サイトテンプレートを登録
# WebTemplateは、サイトテンプレートを利用可能にする標準テンプレートのサイトテンプレートID
Add-SPOSiteDesign `
-Title [サイトテンプレートの名前] `
-WebTemplate "64" `
-SiteScripts $siteScript.Id `
-Description [サイトテンプレートの説明文]
```
■PnP リモートプロビジョニングの初回利用
```
Install-Module -Name PnP.PowerShell
```
■PnP リモートプロビジョニングの2回目以降の利用
```
Import-Module -Name PnP.PowerShell
```
■PnP プロビジョニングテンプレート作成
```
# テンプレートサイトに接続
Connect-PnPOnline `
-Url [テンプレートサイトの URL] `
-Interactive
# プロビジョニングテンプレートを作成
Get-PnPSiteTemplate `
-Out [テンプレートファイルのフルパス.xml] `
-Config [コンフィグファイルのフルパス.json]
```
■PnP プロビジョニングテンプレートの適用
```
# テンプレートを適用したいサイトに接続
Connect-PnPOnline `
-Url [テンプレートを適用したいサイトの URL] `
-Interactive
# テンプレートの適用
Invoke-PnPSiteTemplate `
-Path [テンプレートファイルのフルパス.xml] `
-ClearNavigation
```
[AdSense-B]
