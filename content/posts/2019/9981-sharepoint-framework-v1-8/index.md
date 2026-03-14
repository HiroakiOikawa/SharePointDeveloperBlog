---
title: "SharePoint Framework v1.8 の変更点"
description: "2019年3月8日に SharePoint Framework v1.8 がリリースされました。 この記事では v1.8 の変更点について気になるところだけ抜粋して記載します。 詳細は以下のリリースノートを確認してください。 SharePo…"
date: 2019-03-19T04:15:15+09:00
slug: "9981-sharepoint-framework-v1-8"
categories: ["Office 365", "SharePoint", "開発とプログラミング"]
tags: ["1.8", "SharePoint", "SharePoint Framework", "SPFx"]
aliases: ["/article/9981/"]
draft: false
---
2019年3月8日に SharePoint Framework  v1.8 がリリースされました。
この記事では v1.8 の変更点について気になるところだけ抜粋して記載します。
詳細は以下のリリースノートを確認してください。
[SharePoint Framework v1.8 release notes](https://github.com/SharePoint/sp-dev-docs/wiki/SharePoint-Framework-v1.8-release-notes)

## Teams タブ

- v1.7 ではプレビュー版としてリリースされていましたが、v1.8 で正式サポートとなりました。
- 「Teams タブ」は SharePoint Framework の Web パーツの開発と同じ開発手法で開発したカスタムアプリケーションを Microsoft Teams に「タブ」として追加できるようにするためのソリューションです。

[SharePoint Framework を使用した Microsoft Teams タグの作成](https://docs.microsoft.com/ja-jp/sharepoint/dev/spfx/integrate-with-teams-introduction)

## App ページ

- v1.7 では Single Part App Page と呼ばれていた機能が、App Pages としてリリースされました。
- App ページは、単一の Web パーツだけが配置された、ユーザーがページのレイアウトやコンテンツの変更ができないページを作成するためのソリューションです。

[SharePoint Online での Single Part App Pages の使用](https://docs.microsoft.com/ja-jp/sharepoint/dev/spfx/web-parts/single-part-app-pages)

## 分離された Web パーツ (Domain isolated web parts)

- v1.7 ではプレビュー版としてリリースされていましたが、v1.8 で正式サポートとなりました。
- 通常の Web パーツは、Webパーツが配置されたページのコンテキストで動作しますが、分離された Web パーツは iFrame として作成されるため、別のコンテキストとして動作させることができます。
  これにより、Web パーツで使用する API に対して Azure AD でアクセス許可を設定する際に、特定の分離された Web パーツに対してだけ、アクセスを許可するというような指定ができるようになります。

[分離された Web パーツ](https://docs.microsoft.com/ja-jp/sharepoint/dev/spfx/web-parts/isolated-web-parts)

## その他

- 古いバージョンの Fabric CSS をロードしないようにした
- Web パーツの背景色について、テーマの背景色を使用するようにするプロパティを追加した
- Web パーツのプロパティペインのコードを sp-webpart-base から sp-property-pane に移動した

 
[AdSense-B]
