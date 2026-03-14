---
title: "SharePoint Web Service API の一部が廃止されます"
description: "SharePoint Server の初期の頃から実装されていた、Web Service API の一部が遂に廃止されるようです。既に大部分が移行済みかと思いますが、もしまだこの API を利用している場合は、移行が必要となります。"
date: 2020-09-05T12:42:58+09:00
slug: "10343-sharepoint-web-service-api"
categories: ["Office 365", "SharePoint", "開発とプログラミング"]
tags: ["CSOM", "SharePoint", "WebService"]
aliases: ["/article/10343/"]
draft: false
---
# はじめに

SharePoint Server の初期の頃から実装されていた、Web Service API の一部が遂に廃止されるようです。
既に大部分が移行済みかと思いますが、もしまだこの API を利用している場合は、移行が必要となります。
Microsoft 365 管理センターにアクセス可能な方は以下のリンクから公式メッセージを確認してください。
<https://admin.microsoft.com/AdminPortal/Home#/messagecenter?id=MC221387&MCLinkSource=MajorUpdate>

# 廃止される API

[Microsoft.SharePoint.SoapServer.WebPartPagesWebService](https://docs.microsoft.com/ja-jp/dotnet/api/microsoft.sharepoint.soapserver.webpartpageswebservice?view=sharepoint-server&WT.mc_id=M365-MVP-4012897) クラスの以下のメソッド

- [AddWebPart](https://docs.microsoft.com/en-us/dotnet/api/microsoft.sharepoint.soapserver.webpartpageswebservice.addwebpart?view=sharepoint-server&WT.mc_id=M365-MVP-4012897)
- [AddWebPartToZone](https://docs.microsoft.com/en-us/dotnet/api/microsoft.sharepoint.soapserver.webpartpageswebservice.addwebparttozone?view=sharepoint-server&WT.mc_id=M365-MVP-4012897)
- [SaveWebPart](https://docs.microsoft.com/en-us/dotnet/api/microsoft.sharepoint.soapserver.webpartpageswebservice.savewebpart?view=sharepoint-server&WT.mc_id=M365-MVP-4012897)
- [SaveWebPart2](https://docs.microsoft.com/en-us/dotnet/api/microsoft.sharepoint.soapserver.webpartpageswebservice.savewebpart2?view=sharepoint-server&WT.mc_id=M365-MVP-4012897)
- [GetWebPartPageConnectionInfo](https://docs.microsoft.com/en-us/dotnet/api/microsoft.sharepoint.soapserver.webpartpageswebservice.getwebpartpageconnectioninfo?view=sharepoint-server&WT.mc_id=M365-MVP-4012897)

# 廃止時期

2020年10月初～中旬

# 対応方法

Web Service API は今後も徐々に廃止が進むものと思われますが、今後は CSOM(Client Side Object Model) を使った実装に切り替えていく必要があります。
今回廃止される Web パーツを操作するための API は、CSOM の [Microsoft.SharePoint.Client.WebParts.LimitedWebPartManager](https://docs.microsoft.com/en-us/previous-versions/office/sharepoint-csom/ee545315(v=office.15)?WT.mc_id=M365-MVP-4012897) クラスにて同等のものが提供されています。
[AdSense-B]
