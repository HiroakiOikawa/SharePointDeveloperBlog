---
title: "SharePoint Framework v1.15 の変更点"
description: "2022年6月21日に SharePoint Framework v1.15 がリリースされました。この記事では v1.15 の変更点について、ダイジェスト的にまとめたいと思います。"
date: 2022-07-09T16:15:02+09:00
slug: "10633-sharepoint-framework-v1-15"
categories: ["Office 365", "SharePoint"]
tags: ["M365Dev", "Microsoft365dev", "SharePoint", "SPFx"]
aliases: ["/article/10633/"]
draft: false
---
2022年6月21日に SharePoint Framework v1.15 がリリースされました。
この記事では v1.15 の変更点について、ダイジェスト的にまとめたいと思います。
元ネタは以下のリリースノートになりますので、詳しく見たい方はリリースノートを参照してください。
[SharePoint Framework v1.15 のリリース ノート | Microsoft Docs](https://docs.microsoft.com/ja-jp/sharepoint/dev/spfx/release-1.15)

# 新機能

v1.15 で追加された機能の一覧です。

## フォームカスタマイザー拡張機能のリリース

- リスト及びライブラリの参照、登録、更新フォームに対して、フォームのビジュアルデザインの変更、保存ボタンクリック時の処理追加などが可能

## コマンドセットの更新

- コマンドセットで廃止された onListViewUpdated イベントの代わりに listViewStateChanged イベントを使用するように更新

## イメージヘルパー API のリリース

- SharePoint Framework のコードから、SharePoint に保存されたページやドキュメントの自動生成されたサムネイル画像と、SharePoint に保存された画像ファイルの最適化されたURLにアクセスすることが可能

## Viva Connections アプリの位置情報アクションの追加

- Viva Connections アプリにて、位置情報に関する「位置情報を取得する」アクションと「位置情報を表示する」アクションが追加

## サポートバージョンの更新

- Node.js v16 をサポート
- Microsoft Graph JavaScript SDK v3 をサポート
- TypeScript v4 をサポート

# プレビュー機能

v1.15 でプレビューとして追加された機能で、v1.16 以降で正式リリースとなります。
これらの機能は v1.14 の時からプレビューで追加されていました。

- アダプティブカード拡張機能のカードビューのキャッシュ機能追加
- アダプティブカード拡張機能のエラーハンドラメソッドの追加
- アダプティブカード拡張機能の新アクション (メディア選択、場所の取得・表示) の追加

その他、前バージョンで非推奨となっていた API の削除や多数のバグフィックスを含みます。

# Docker ファイルの紹介

SharePoint Framework v1.15 に対応した Dockerfile が github で公開されていますので、必要に応じて利用してください。
[docker-spfx/Dockerfile at master · pnp/docker-spfx (github.com)](https://github.com/pnp/docker-spfx/blob/master/Dockerfile)
[AdSense-B]
