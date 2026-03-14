---
title: "SharePoint Framework v1.9.1 の変更点"
description: "2019年8月14日に SharePoint Framework v1.9.1 がリリースされました。 この記事では v1.9.1 の変更点について気になるところだけ抜粋して記載します。 詳細は以下のリリースノートを確認してください。 Sh…"
date: 2019-11-30T15:03:59+09:00
slug: "9989-sharepoint-framework-v1-9-1"
categories: ["Office 365", "SharePoint", "開発とプログラミング"]
tags: ["OfficeDev", "SharePoint", "SPFx"]
aliases: ["/article/9989/"]
draft: false
---
2019年8月14日に SharePoint Framework  v1.9.1 がリリースされました。
この記事では v1.9.1 の変更点について気になるところだけ抜粋して記載します。
詳細は以下のリリースノートを確認してください。
[SharePoint Framework v1.9 release notes](https://github.com/SharePoint/sp-dev-docs/wiki/SharePoint-Framework-v1.9.1-release-notes)

## Library Components

- SharePoint Framework におけるコードの再利用を実現するための機能で、自作のファンクションなどを共通コードライブラリとして SharePoint 環境に展開するための機能です。

[SharePoint Framework でライブラリコンポーネントタイプを使用する](https://docs.microsoft.com/ja-jp/sharepoint/dev/spfx/library-component-overview)

## GraphHttpClient の廃止

- Graph API を呼び出すためのクラスとして、GraphHttpClient がありましたがこれが削除されました。
- 代わりに MSGraphClient を使用することになります。

[AdSense-B]
