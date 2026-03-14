---
title: "SharePoint Framework v1.14 の変更点"
description: "2022年2月14日に SharePoint Framework v1.14 がリリースされました。この記事では v1.14 の変更点について、ダイジェスト的にまとめたいと思います。"
date: 2022-02-24T01:28:51+09:00
slug: "10545-sharepoint-framework-v1-14"
categories: ["Office 365", "SharePoint", "SPFx", "開発とプログラミング"]
tags: ["M365Dev", "Microsoft365dev", "SharePoint", "SPFx"]
aliases: ["/article/10545/"]
draft: false
---
2022年2月14日に SharePoint Framework v1.14 がリリースされました。
[Announcing SharePoint Framework 1.14 – with updates for Viva Connections, Microsoft Teams and SharePoint - Microsoft 365 Developer Blog](https://devblogs.microsoft.com/microsoft365dev/announcing-sharepoint-framework-1-14-with-updates-for-viva-connections-microsoft-teams-and-sharepoint/)
この記事では v1.14 の変更点について、ダイジェスト的にまとめたいと思います。
元ネタは以下のリリースノートになりますので、詳しく見たい方はリリースノートを参照してください。
[SharePoint Framework v1.14 のリリース ノート | Microsoft Docs](https://docs.microsoft.com/ja-jp/sharepoint/dev/spfx/release-1.14?WT.mc_id=M365-MVP-4012897)

# 新機能

v1.14 で追加された機能の一覧です。

## Viva Connection 用のアダプティブカード拡張機能 (ACE) の更新

- ACE スキャフォールディングの更新
- 現在の ViewNavigator を取得する API を追加

## リストビューコマンドセットの更新

- コマンドセットの変更をリストビューに通知するメソッドを追加
- リストビューの展開状態を示すプロパティを追加
- リストビューの状態が変更されたことを通知するイベントを追加
- コマンドセットを Disabled 状態にするプロパティを追加

## Webパーツの更新

- 開発中の Web パーツであることを示すプロパティの追加
- DOM をクリアするためのコールバックの追加
- ページ上でテーマが変更された際に呼び出されるメソッドの追加
- Web パーツの新しいテンプレート

## その他

- スキャフォールディングにおける一部オプションの廃止
- localhost からコンポーネントを読み込んでいるか否かを示すプロパティの追加
- プロパティウィンドウのグループ名を非表示にするプロパティの追加
- serve.json に ipAddress プロパティを追加
- SharePoint に保存された画像を取り扱うための Image Helper API の追加

# プレビュー機能

v1.14 でプレビューとして追加された機能で、v1.15 以降で正式リリースとなります。

- アダプティブカード拡張機能のカードビューのキャッシュ機能追加
- アダプティブカード拡張機能のエラーハンドラメソッドの追加
- アダプティブカード拡張機能の新アクション (メディア選択、場所の取得・表示) の追加

 
その他、前バージョンで非推奨となっていた API の削除や多数のバグフィックスを含みます。
[AdSense-B]
