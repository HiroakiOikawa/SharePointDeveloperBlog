---
title: "ワークフロー実行中の「フォームをレンダリングできません」エラー"
description: "現象： ワークフローを実行中に下図の通り「フォームをレンダリングできません・・・」というエラーが発生し、アイテムを開くことができない。 原因： メッセージの通り、State Serviceが構成されていないことが原因。 対処法： 以下のリン…"
date: 2010-03-07T01:52:04+09:00
slug: "3961-post"
categories: ["SharePoint 2010", "開発とプログラミング"]
aliases: ["/article/3961/"]
draft: false
---
**現象：**
ワークフローを実行中に下図の通り「フォームをレンダリングできません・・・」というエラーが発生し、アイテムを開くことができない。
![troublestateservice](./troublestateservice.png)
**原因：**
メッセージの通り、State Serviceが構成されていないことが原因。
**対処法：**以下のリンクの通り、State Serviceを構成することで、ワークフローが動くようになる。
[State Service アプリケーションを構成する](http://sharepoint.orivers.jp/reference/SitePages/State Serviceサービスアプリケーションを構成する.aspx)
