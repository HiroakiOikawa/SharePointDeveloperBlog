---
title: "絶対URLからSPWebを取得する"
description: "絶対URLからSPWebを取得する方法です。 SPWebを取得するには、まずSPSiteを取得する必要があります。 SPSiteの取得は、 別の記事 にも書いた通り、SPSiteのコンストラクタの引数に、絶対URLを渡して取得します。 その…"
date: 2009-09-22T10:09:41+09:00
slug: "4281-url-spweb"
categories: ["SharePoint 2007", "開発とプログラミング"]
aliases: ["/article/4281/"]
draft: false
---
絶対URLからSPWebを取得する方法です。
SPWebを取得するには、まずSPSiteを取得する必要があります。
SPSiteの取得は、[別の記事](http://sharepoint.orivers.jp/reference/SharePoint2007/絶対URLからSPSiteを取得する.aspx)にも書いた通り、SPSiteのコンストラクタの引数に、絶対URLを渡して取得します。
その後、続けてOpenWebメソッドを引数なしで呼び出すことで、SPWebを取得できます。
以下のコードでは、testというサブサイトを指定しています。
このコードの結果は、testサブサイトが取得できます。

```
1: SPSite site = new SPSite("http://test.co.jp/test/Lists/List1/DispForm.aspx?ID=1");
```
```
2: SPWeb web = site.OpenWeb();
```

SPSiteと同様、サイトが特定できれば、後半のURLは存在しないコンテンツを指していても問題ありません。
以下のコードでは、test2という存在しないサブサイトを指しています。
このコードの結果は、[http://test.co.jp](http://test.co.jp/)のトップサイトが取得できます。

```
1: SPSite site = new SPSite("http://test.co.jp/test2/Lists/List1/DispForm.aspx?ID=1");
```
```
2: SPWeb web = site.OpenWeb();
```

このやり方の場合、SPSiteが取得できないことはあっても、SPWebが取得できないことはありません。
SPSiteが取得できていれば、存在しないサブサイト名を指定していても、OpenWebメソッドによりSPSiteのRootWebが取得できます。
逆に言うと、URLの間違いに気づかず、関係ないSPWebを使って処理をしてしまうことがあるので、注意が必要です。
