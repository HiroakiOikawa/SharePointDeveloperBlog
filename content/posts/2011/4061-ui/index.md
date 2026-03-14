---
title: "マスターページを変更してリボンUIのタブを消す方法"
description: "リボンUIのタブ、サイトの操作、ログイン名などを消すには、マスターページを編集する必要があります。 この記事では、その方法を記載します。 なお、リボンUIのタブを消すと、本サイトのヘッダのようになります。 １．SharePoint Desi…"
date: 2011-03-17T02:44:50+09:00
slug: "4061-ui"
categories: ["SharePoint 2010", "開発とプログラミング"]
aliases: ["/article/4061/"]
draft: false
---
リボンUIのタブ、サイトの操作、ログイン名などを消すには、マスターページを編集する必要があります。
この記事では、その方法を記載します。
なお、リボンUIのタブを消すと、本サイトのヘッダのようになります。
**１．SharePoint Designerでマスターページを開く**リボンUIのタブを消したいマスターページを開き、[ファイルの編集]メニューをクリックします。
ここでは、v4.masterをサンプルとして使います。
**２．マスターページを編集する**コードエディタ上で、以下のタグを検索します。
​<div id="s4-ribbonrow" class="s4-pr s4-ribbonrowhidetitle">
このタグがリボンUIの開始タグになります。
私が試した環境では61行目にこのタグがありました。
終了タグは、243行目の二つ目の</div>になります。
上記タグを中身ごと削除すれば、リボンUIが表示されなくなりますが、それではページ編集などもできなくなってしまいます。
したがって、管理権限など特定の権限を持つ人にだけリボンUIが表示されるようにします。
61行目のタグの前に、以下のタグを追加します。
<SharePoint:SPSecurityTrimmedControl runat="server" PermissionsString="DeleteListItems">
さらに、243行目の</div>の後に、</SharePointSPSecurityTrimmedControl>を追加します。
最終的には以下のような感じになります。
61行目
<SharePoint:SPSecurityTrimmedControl runat="server" PermissionsString="DeleteListItems"><div id="s4-ribbonrow" class="s4-pr s4-ribbonrowhidetitle">
<div id="s4-ribboncont"><SharePoint:SPRibbon
243行目
</asp:UpdatePanel></div></div></SharePoint:SPSecurityTrimmedControl>
**３．マスターページを保存する**編集が終わったら、マスターページを保存します。
なお、編集内容の確認のために、iisresetなどを行う必要はありません。
