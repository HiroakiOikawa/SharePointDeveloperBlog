---
title: "Restore-SPSite で DirectoryNotFoundException"
description: "Restore-SPSite でサイトコレクションのリストアを行おうとした際に、以下のエラーが発生しリストアに失敗しました。 restore-spsite : <nativehr>0x80070003</nativehr><nativest…"
date: 2013-08-31T23:01:57+09:00
slug: "5431-restore-spsite-directorynotfoundexception"
categories: ["SharePoint 2013", "インストールと設定、管理"]
aliases: ["/article/5431/"]
draft: false
---
Restore-SPSite でサイトコレクションのリストアを行おうとした際に、以下のエラーが発生しリストアに失敗しました。
restore-spsite : <nativehr>0x80070003</nativehr><nativestack></nativestack>
発生場所 行:1 文字:1
+ restore-spsite -identity http://sp2013dev/sites/restore -path c:backupsite.bak
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidData: (Microsoft.Share...dletRestoreSite:
   SPCmdletRestoreSite) [Restore-SPSite]、DirectoryNotFoundException
    + FullyQualifiedErrorId : Microsoft.SharePoint.PowerShell.SPCmdletRestoreSite

リストア先の URL やバックアップファイルの場所など、色々調べましたが原因わからず。
調べてみると同じような現象が起きているという情報を見つけました。
[http://spreza.blogspot.jp/2013/05/restore-spsite-force-failed-by.html](http://spreza.blogspot.jp/2013/05/restore-spsite-force-failed-by.html "http://spreza.blogspot.jp/2013/05/restore-spsite-force-failed-by.html")

この方の調査によると、2013 年 4 月の CU を適用して治ったとのこと。
私の環境にも CU があたっていなかったので、2013 年 8 月の CU をあて、構成ウィザードを実行しなおしたところ、問題は解消されました。
