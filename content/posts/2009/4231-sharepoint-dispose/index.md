---
title: "SharePoint オブジェクト の Dispose について"
description: "SPSiteやSPWebといった、SharePoint オブジェクトは、COMオブジェクトであるために、.NETのガベージコレクタではメモリが解放されません。 従って、きちんとDisposeをしてあげないといけないわけです。 Dispose…"
date: 2009-08-06T09:57:47+09:00
slug: "4231-sharepoint-dispose"
categories: ["SharePoint 2007", "開発とプログラミング"]
aliases: ["/article/4231/"]
draft: false
---
SPSiteやSPWebといった、SharePoint オブジェクトは、COMオブジェクトであるために、.NETのガベージコレクタではメモリが解放されません。
従って、きちんとDisposeをしてあげないといけないわけです。
Disposeをするタイミングについてまとまった記事があったのでご紹介します。
<http://blogs.msdn.com/rogerla/archive/2008/02/12/sharepoint-2007-and-wss-3-0-dispose-patterns-by-example.aspx>

<http://www.sharepointdevwiki.com/display/public/When+to+Dispose+SharePoint+objects>
Disposeが正しく行われるようコードが書かれているかを自動的にチェックするツールが存在します。
私の環境ではエラーが出てうまく動いていません。。。

<http://code.msdn.microsoft.com/SPDisposeCheck>
