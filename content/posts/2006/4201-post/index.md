---
title: "対応ブラウザ"
description: "SharePoint Server 2007の対応ブラウザに関する正式なドキュメントを見たことはないですが、SharePoint Team Blogに、この件に関する投稿があり、そこに対応ブラウザについて書いてました。 Improvemen…"
date: 2006-10-24T09:52:15+09:00
slug: "4201-post"
categories: ["SharePoint 2007", "全般"]
aliases: ["/article/4201/"]
draft: false
---
SharePoint Server 2007の対応ブラウザに関する正式なドキュメントを見たことはないですが、SharePoint Team Blogに、この件に関する投稿があり、そこに対応ブラウザについて書いてました。
[Improvements in Web Browser Compatibility](http://blogs.msdn.com/sharepoint/archive/2006/07/19/671735.aspx)
この記事によると、SharePoint Server 2007は、インターネットを意識しているので、IE以外のブラウザにも対応するとのこと。
ただし、対応の度合いは異なり、Level1、Level2と段階があります。
**Level1**
対応ブラウザ
・IE6
・IE７
対応状況
・SharePoint Server 2007 のUIをフルサポート
・管理者ページはLevel1ブラウザだけがサポート対象
**Level2**
対応ブラウザ
・Firefox 1.5以上
・Netscape 8.1以上(UNIX版は7.2以上)
・Mozila 1.7以上
・Safari 2.0以上
対応状況
・リッチテキストやコンテキストメニューなど、いくつかのUIがサポートされない
・管理者ページはサポートされない
ちなみに、試しにリストにまったく上がっていないIE5.5で試してみましたが、以下の通り、とても悲惨な結果になりました。
IE5.5ではまったく使い物になりません。。。
・ページ表示時に多数のスクリプトエラー発生
・Webパーツ右横の▼ボタンなど、ドロップダウン系のメニューをクリックすると軒並みスクリプトエラー発生
・リストなどのアイテムにファイルを添付しようとするとスクリプトエラー発生
まぁ、当然のことですが、IE6以上を使うのがベストですね。
