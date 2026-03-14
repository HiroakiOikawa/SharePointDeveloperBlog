---
title: "ベストプラクティスに従い設定を分析する"
description: "SharePointにはたくさんの設定項目がありますが、これらの設定項目が最良の状態になっているかどうかを自動的に調べてくれるツールが、マイクロソフトから無償で提供されています。 それが、Microsoft Best Practices A…"
date: 2009-11-01T10:27:34+09:00
slug: "4331-post"
categories: ["SharePoint 2007", "全般"]
aliases: ["/article/4331/"]
draft: false
---
SharePointにはたくさんの設定項目がありますが、これらの設定項目が最良の状態になっているかどうかを自動的に調べてくれるツールが、マイクロソフトから無償で提供されています。
それが、Microsoft Best Practices Analyzer for SharePointです。
このツールを使うと、SharePointの各種設定について、ベストプラクティスと異なる部分を重要度別にレポートしてくれます。
英語しかないツールですが、ファーム構築後に一度このツールを実行して、設定状況を確認してみるとよいと思います。
**＜インストール方法＞**以下のサイトからファイルをダウンロード＆実行し、適当なフォルダに解凍してください。
<http://www.microsoft.com/downloads/details.aspx?familyid=cb944b27-9d6b-4a1f-b3e1-778efda07df8&displaylang=en>
いろいろと動作条件があるので、可能であればインデックスサーバーとかにインストールするのが良いと思います。
**＜実行方法＞**このツールは、コマンドラインで動作します。
コマンドプロンプトを立ち上げ、ツールを解凍したフォルダまで移動し、以下のコマンドを入力して実行してください。

```
1: sharepointbpa -cmd analyze -substitutions SERVER\_NAME centraladminservername
```

[centraladminservername]の部分には、全体管理サイトをホストするサーバーのホスト名を入力してください。
それ以外のところは上記のままで良いです。
処理が完了すると、ツールを解凍したのと同じフォルダに、sharepointbpa.report.htmというファイルが作成されます。
このファイルに、設定に関する分析結果が記録されています。
**＜結果サンプル＞**試しに、SharePointをインストールして構成ウィザードが終わったばかりの状態でツールを実行してみました。
その時に出力されたレポートは以下になります。ご参考までに。
Microsoft Best Practices Analyzer for Microsoft Windows SharePoint Services 3.0 and the 2007 Microsoft Office System

**Run Date:** November 1, 2009 02:22:06

Warnings (4)

Warning Details

**Title:**
Customer Experience Improvement Program is not enabled

**Severity:**
1

**Description:**

The Customer Experience Improvement Program is designed to improve the quality, reliability, and performance of Microsoft Products and Technologies. With your permission, anonymous information about your server will be sent to Microsoft to help us improve SharePoint Products and Technologies. To participate in the Customer Experience Improvement Program, from SharePoint 3.0 Central Administration, open the Operations pages, and then in the Logging and Reporting area click Diagnostic logging. On the Diagnostic Logging page select, Yes, I am willing to participate anonymously in the Customer Experience Improvement Program (Recommended).

**Title:**
Incoming e-mail settings are not configured

**Severity:**
1

**Description:**

You should configure the incoming e-mail settings to allow the document libraries and lists on your SharePoint sites to receive and archive incoming e-mail. SharePoint sites can archive e-mail discussions as they happen, save e-mailed documents, and show e-mailed meetings on site calendars. Configure the SharePoint Directory Management Service to provide support for e-mail distribution group creation and management. You must also install the Windows Server SMTP service on the SharePoint server that receives and processes incoming e-mail. To enable incoming e-mail for this server, from SharePoint 3.0 Central Administration, open the Operations pages, and then in the Topology and Services area click Incoming e-mail settings. On the Configure Incoming E-Mail Settings page, configure the settings for your incoming e-mail.

**Title:**
Outgoing e-mail settings are not configured

**Severity:**
1

**Description:**

You should specify the SMTP e-mail server so that users can receive invitations, alerts, and notifications, including notifications used for workflow. To enable outgoing e-mail for this server, from SharePoint 3.0 Central Administration, open the Operations pages, and then in the Topology and Services area click Outgoing e-mail settings. On the Outgoing E-Mail Settings page, configure the settings for your outgoing e-mail.

**Title:**
Highly Available Central Administration Capability

**Severity:**
3

**Description:**

Only one instance of the SharePoint 3.0 Central Administration Web site exists in your installation. To make sure that you can administer the farm in the case of a failure of a server hosting SharePoint 3.0 Central Administration, you should have SharePoint 3.0 Central Administration installed on at least two servers in the farm.
