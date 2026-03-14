---
title: "SharePoint Framework v1.10 の変更点"
description: "SharePoint Framework v1.10 のリリースノートをもとに、気になる変更点を抜粋しました。"
date: 2020-01-19T01:30:27+09:00
slug: "10049-sharepoint-framework-v1-10"
categories: ["Office 365", "開発とプログラミング"]
tags: ["OfficeDev", "SharePoint", "SharePoint Framework", "SPFx"]
aliases: ["/article/10049/"]
draft: false
---
2020年1月7日に SharePoint Framework v1.10 がリリースされました。
この記事では v1.10 の変更点について気になるところだけ抜粋して記載します。
詳細は以下のリリースノートを確認してください。
[SharePoint Framework v1.10 release notes](https://github.com/SharePoint/sp-dev-docs/wiki/SharePoint-Framework-v1.10-release-notes?WT.mc_id=M365-MVP-4012897)

## Teams Personal Apps 開発への対応

- SharePoint Framework で、Teams の個人用アプリの開発が行えるようになりました。
- 個人用アプリは、チームやチャネルを横断して個人視点で利用するアプリの事を指します。
- 参考サイト：[docs](https://docs.microsoft.com/ja-jp/microsoftteams/platform/concepts/design/personal-apps?WT.mc_id=M365-MVP-4012897)

## リストの更新通知のサブスクライブ

- ドキュメントライブラリに格納されたファイルが更新されると、任意のメソッドがコールバックさせることができる機能が正式リリースとなりました。
- 参考サイト：[docs](https://docs.microsoft.com/ja-jp/sharepoint/dev/spfx/subscribe-to-list-notifications?WT.mc_id=M365-MVP-4012897)

## Application Customizer の事前領域確保

- Application Customizer で使用する領域を事前に確保することで、Application Customizer のロードに時間がかかっても画面の表示乱れが起きなくなります。
- 参考サイト：[docs](https://docs.microsoft.com/en-us/sharepoint/dev/spfx/extensions/basics/preallocated-space-placeholders?WT.mc_id=M365-MVP-4012897)

## Office アドイン開発への対応 (dev preview)

- SharePoint Framework で、 Office アドインの開発が行えるようになりました。
  ただし、このリリースは開発者プレビューの段階です。
- 参考サイト：[docs](https://docs.microsoft.com/en-us/sharepoint/dev/spfx/office-addins-create?WT.mc_id=M365-MVP-4012897)

## Microsoft Search 拡張機能開発への対応 (dev preview)

- Microsoft Search の検索クエリをカスタマイズするために使用する拡張機能の開発が行えるようになりました。
  ただし、このリリースは開発者プレビュー段階です。
- 参考サイト：[docs](https://docs.microsoft.com/en-us/sharepoint/dev/spfx/building-search-extensions?WT.mc_id=M365-MVP-4012897)

## Teams コンテキストへのアクセス手段の変更

- これまで Teams コンテキストにアクセスするには、this.context.microsoftTeams  プロパティを使用していましたが、これが廃止になりました。
  代わりに、this.context.sdks.microsoftTeams  を使用します。

## TypeScript のバージョン変更

- TypeScript のバージョンが v3.3 になりました。

 
[AdSense-B]
