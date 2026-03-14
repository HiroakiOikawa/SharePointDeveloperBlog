---
title: "絶対URLからSPListを取得する"
description: "絶対URLからSPListを取得する方法です。 結論から言うと、SPListはhttp://から始まる絶対URLで取得することができません。 SPListはホスト名からの相対URLで取得します。管理パスとかサブサイトとかで階層がどんなに深く…"
date: 2009-09-22T10:20:00+09:00
slug: "4291-url-splist"
categories: ["SharePoint 2007", "開発とプログラミング"]
aliases: ["/article/4291/"]
draft: false
---
絶対URLからSPListを取得する方法です。
結論から言うと、SPListはhttp://から始まる絶対URLで取得することができません。
SPListはホスト名からの相対URLで取得します。管理パスとかサブサイトとかで階層がどんなに深くなっていても、ホスト名からの相対URLを指定します。
従って、以下のコードのように何らかのやり方でホスト名までの部分を削除し、その値をSPWebのGetListメソッドに渡します。

```
1: Uri uri = new Uri("http://test.co.jp/test/Lists/List1/DispForm.aspx?ID=1");
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
5: SPList list = web.GetList(targetUrl);
```

これで問題なさそうですが、SPWeb.GetListメソッドは一つだけ注意点があります。
SPWeb.GetListメソッドは、引数として渡されたURLのファイル名の部分まで意味を持ちます。
例えば、リスト名までは合っていてもファイル名の部分に間違いがあると、SPListを取得することができません。
以下のコードは、DispForm.aspxがDisp.aspxと間違えているため、SPListは取得できません。

```
1: web.GetList(“/test/Lists/List1/Disp.aspx?ID=1”);
```

なお、ID=1の部分で存在しないアイテムIDが指定されていても、ファイル名まで合っていれば問題なくSPListを取得できます。
従って、SPWeb.GetListメソッドでSPListを取得する場合は、ファイル名から先のURLは削除しておいたほうが良いです。
指定の絶対URLでSPListが取得できない場合、FileNotFoundExceptionが発生します。
