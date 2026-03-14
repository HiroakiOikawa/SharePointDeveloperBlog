---
title: "絶対URLからSPSiteを取得する"
description: "絶対URLからSPSiteを取得する方法です。 SPSiteのコンストラクタの引数に、絶対URLを渡すとSPSiteが取得できます。"
date: 2009-09-22T10:06:57+09:00
slug: "4271-url-spsite"
categories: ["SharePoint 2007", "開発とプログラミング"]
aliases: ["/article/4271/"]
draft: false
---
絶対URLからSPSiteを取得する方法です。
SPSiteのコンストラクタの引数に、絶対URLを渡すとSPSiteが取得できます。

```
1: SPSite site = new SPSite(http://test.co.jp/test/Lists/List1/DispForm.aspx?ID=1);
```

管理パスを定義している場合は、SharePointが自動的に管理パスかどうかを判断し、適切なSPSiteを返してくれます。
例えば、[http://test.co.jp](http://test.co.jp/)直下のサイトコレクションの下位にtest1という管理パスを定義し、そこにサイトコレクションを作成した場合、以下のコードではtest1のサイトコレクションを取得します。

```
1: SPSite site = new SPSite("http://test.co.jp/test1/Lists/List1/DispForm.aspx?ID=1");
```

サイトコレクションが特定できれば、後半のURLは存在しないコンテンツを指していても問題ありません。
以下のコードでは、test2という存在しないサブサイトを指しています。
このコードの結果は、[http://test.co.jp](http://test.co.jp/)のサイトコレクションが取得できます。

```
1: SPSite site = new SPSite("http://test.co.jp/test2/Lists/List1/DispForm.aspx?ID=1");
```

指定の絶対URLでSPSiteが取得できない場合、FileNotFoundExceptionが発生します。
