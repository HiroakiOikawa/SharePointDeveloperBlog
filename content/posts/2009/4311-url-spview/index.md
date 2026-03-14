---
title: "絶対URLからSPViewを取得する"
description: "絶対URLからSPViewを取得する方法です。 SPViewはSPListと同様、http://から始まる絶対URLで取得することができません。 SPViewはホスト名からの相対URLで取得します。管理パスとかサブサイトとかで階層がどんなに…"
date: 2009-09-23T10:23:26+09:00
slug: "4311-url-spview"
categories: ["SharePoint 2007", "開発とプログラミング"]
aliases: ["/article/4311/"]
draft: false
---
絶対URLからSPViewを取得する方法です。
SPViewはSPListと同様、http://から始まる絶対URLで取得することができません。
SPViewはホスト名からの相対URLで取得します。管理パスとかサブサイトとかで階層がどんなに深くなっていても、ホスト名からの相対URLを指定します。
従って、以下のコードのように何らかのやり方でホスト名までの部分を削除し、その値をSPWebのGetViewFromUrlメソッドに渡します。

```
1: Uri uri = new Uri("http://test.co.jp/test/Lists/List1/AllItems.aspx");
```
```
2: SPSite site = new SPSite(uri.AbsoluteUri);
```
```
3: SPWeb web = site.OpenWeb();
```
```
4: string targetUrl = uri.AbsoluteUrl.Replace(string.Format("{0}{1}", uri.GetLeftPart(UriPartial.Scheme), uri.Host), "");
```
```
5: SPView view = web.GetViewFromUrl(targetUrl);
```

指定の絶対URLでSPViewが取得できない場合、SPExceptionが発生します。
SPWebやSPListが取得できないときは、FileNotFoundExceptionが発生するのに、SPViewだけはSPExceptionなので、注意が必要です。
