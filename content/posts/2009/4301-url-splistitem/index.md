---
title: "絶対URLからSPListItemを取得する"
description: "絶対URLからSPListItemを取得する方法です。 SPListItemの取得方法は、対象がファイルまたはフォルダか、リストアイテムかで若干異なります。 ファイル、フォルダの取得 ファイルまたはフォルダのSPListItemを取得する場…"
date: 2009-09-23T10:21:15+09:00
slug: "4301-url-splistitem"
categories: ["SharePoint 2007", "開発とプログラミング"]
aliases: ["/article/4301/"]
draft: false
---
絶対URLからSPListItemを取得する方法です。
SPListItemの取得方法は、対象がファイルまたはフォルダか、リストアイテムかで若干異なります。
**ファイル、フォルダの取得**
ファイルまたはフォルダのSPListItemを取得する場合、SPListと同様、ホスト名からの相対URLで取得します。
以下のコードでは、Documentsドキュメントライブラリの直下のtestフォルダ内のmemo.txtのSPListItemを取得します。

```
1: Uri uri = new Uri("http://test.co.jp/Documents/test/memo.txt");
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
5: SPListItem file = web.GetListItem(targetUrl);
```

次は、Documentsドキュメントライブラリの直下のtestフォルダのSPListItemを取得するコードです。

```
1: Uri uri = new Uri("http://test.co.jp/Documents/test");
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
5: SPListItem folder = web.GetListItem(targetUrl);
```

このように、ファイルとフォルダはSPWeb.GetListItemメソッドで取得できます。
なお、SPWeb.GetListItemメソッドに、存在しないファイル、フォルダのURLを渡したり、ビューやドキュメントライブラリなどに所属しないページ(チームサイトのdefault.aspxなど)のURLを渡すと、SPListItemは取得できず、nullが返ります。
**リストアイテムの取得**
リストアイテムのSPListItemを取得するには、まずSPListを取得する必要があります。
その後、URLのクエリ文字列にある「ID」からItemIDを取得して、SPList.GetItemByIdメソッドを呼び出します。

```
1: Uri uri = new Uri("http://test.co.jp/test/Lists/List1/DispForm.aspx?ID=1");
```
```
2: // リストを取得
```
```
3: SPSite site = new SPSite(uri.AbsoluteUri);
```
```
4: SPWeb web = site.OpenWeb();
```
```
5: string targetUrl = uri.AbsoluteUrl.Replace(string.Format("{0}{1}", uri.GetLeftPart(UriPartial.Scheme), uri.Host), "");
```
```
6: SPList list = web.GetList(targetUrl);
```
```
7: // リストアイテムを取得
```
```
8: Regex reg = new Regex(@’[?|&]ID=d”, RegexOptions.IgnoreCase);
```
```
9: int itemId = int.Parse(reg.Match(url.Query).Value.Split(‘=’)[1]);
```
```
10: SPListItem listItem = list.GetItemById(itemId);
```

SPList.GetItemByIdメソッドに、存在しないアイテムのIDを渡すと、ArgumentExceptionが発生します。
最後に番外編として、リストアイテムをSPWeb.GetListItemメソッドで取得する方法を紹介します。
SPWeb.GetListItemメソッドはURLからファイル、フォルダのSPListItemを取得することができますが、リストアイテムのSPListItemを取得することはできません。
ただし、URLを以下のようにすると取得することができます。
例えば、「http://test.co.jp/test/Lists/List1/DispForm.aspx?ID=1」というURLを以下のように変更すると、SPWeb.GetListItemメソッドで取得できるようになります。
「http://test.co.jp/test/Lists/List1/1\_.000」
絶対URLから上記形式への変換が手間でなければ、このやり方で取得してもよいでしょう。
