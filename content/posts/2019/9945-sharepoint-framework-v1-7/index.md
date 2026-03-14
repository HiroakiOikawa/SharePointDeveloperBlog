---
title: "SharePoint Framework v1.7 の変更点"
description: "SharePoint Framework 1.7 の変更点をまとめました。 プレビュー段階のものがほとんどですが、Dynamic Data が正式リリースになりました。 主な変更点 Dynamic Data Web パーツ同士の連携を可能に…"
date: 2019-02-02T10:40:04+09:00
slug: "9945-sharepoint-framework-v1-7"
categories: ["Office 365", "SharePoint", "開発とプログラミング"]
tags: ["SharePoint", "SharePoint Framework", "SPFx"]
aliases: ["/article/9945/"]
draft: false
---
SharePoint Framework 1.7 の変更点をまとめました。
プレビュー段階のものがほとんどですが、Dynamic Data が正式リリースになりました。

# 主な変更点

## Dynamic Data

Web パーツ同士の連携を可能にするための仕組み。
Web パーツ A が自身の情報を動的データとして他の Web パーツに公開し、Web パーツ B が Web パーツ A の動的データをリアルタイムに読み取るということができるようになります。
[動的データを使用した、SharePoint Framework コンポーネントの接続](https://docs.microsoft.com/ja-jp/sharepoint/dev/spfx/dynamic-data)

## 

## SharePoint 2019 のサポート

SharePoint 2019 を正式サポート。

## 

## Teams タブへの対応（開発者プレビュー版）

SharePoint Framework の Web パーツと同じような開発手法で、Teams のタブに追加できるアプリの開発が可能となります。
[SharePoint Framework を使用した Microsoft Teams タブの作成](https://docs.microsoft.com/ja-jp/sharepoint/dev/spfx/integrate-with-teams-introduction)

## 

## SharePoint のページへの Teams タブアプリケーションの組み込み対応（開発者プレビュー版）

SharePoint のページ上に Teams タブのアプリを IFrame で組み込むことが可能となります。
[SharePoint のソリューションとして Microsoft Teams のタブをホスティングする](https://docs.microsoft.com/ja-jp/sharepoint/dev/spfx/using-teams-solutions-in-sharepoint)

## 

## Single Part App Pages（開発者プレビュー版）

ページ上に単一の Web パーツしか設置できないページで、エンドユーザーが自由にページのレイアウト変更や Web パーツの設定変更ができなくなっているページを作成することができます。
[SharePoint Online での Single Part App Pages の使用](https://docs.microsoft.com/ja-jp/sharepoint/dev/spfx/web-parts/single-part-app-pages)

## 

## 分離された Web パーツ（開発者プレビュー版）

Azure AD でセキュリティ保護された API (Microsoft Graph などの Azure AD に登録されている API) へアクセスする Web パーツを、他の Web パーツとは分離された状態で実行するための機能。
Web パーツを分離することにより、Azure AD により保護された API へのアクセストークンを他の Web パーツに横取りされることを防ぐことができます。
分離された Web パーツは IFrame としてページに埋め込まれます。
[分離された Web パーツ](https://docs.microsoft.com/ja-jp/sharepoint/dev/spfx/web-parts/isolated-web-parts)

## 

## ドキュメントライブラリの変更通知のサブスクライブ（開発者プレビュー版）

ドキュメントライブラリに保存されているファイルに変更があった場合に、その変更を通知して他の Web パーツや SharePoint Framework 拡張機能が通知を受信することができます。
現時点ではリストには未対応。
複数のテナントをまたいで通知を受け取ることが可能なようす。
[通知リストの購読](https://docs.microsoft.com/ja-jp/sharepoint/dev/spfx/subscribe-to-list-notifications)
 
 
Dynamic Data については GA された機能なので、実際にサンプルを作ってみたいなと思っています。
 
[AdSense-B]
