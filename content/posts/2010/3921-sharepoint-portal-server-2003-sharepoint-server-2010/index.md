---
title: "SharePoint Portal Server 2003 から SharePoint Server 2010 へのアップグレード"
description: "SharePoint Portal Server 2003(SPS2003) から SharePoint Server 2010 へのアップグレード方法について、TechNetに記載がありました。"
date: 2010-02-28T01:38:09+09:00
slug: "3921-sharepoint-portal-server-2003-sharepoint-server-2010"
categories: ["SharePoint 2010", "インストールと設定、管理"]
aliases: ["/article/3921/"]
draft: false
---
SharePoint Portal Server 2003(SPS2003) から SharePoint Server 2010 へのアップグレード方法について、TechNetに記載がありました。

<http://technet.microsoft.com/ja-jp/library/ee947141(office.14).aspx>

以下、TechNetから一部引用

**1.アップグレードの準備**

a.元のファームに対してアップグレード前のスキャンツールを実行し、また、すべてのカスタマイズ内容をリストアップして、アップグレード作業に備えます。

b.Office SharePoint Server 2007 を実行する小規模の一時的なファームを、x86環境として作成します。

c.完全な SharePoint Server 2010 ファームをセットアップし、構成内容と正常動作を確認します。

**2.第 1 段階のアップグレード: コンテンツを Office SharePoint Server 2007 にアップグレードする**

a.コンテンツ データベースをSPS2003ファームから切断し、それからファームをオフライン状態にします。
ただし、元のファームをすぐに復元して使用を再開できるようにする必要がある場合は、データベースとの接続を維持し、データベースのコピーを作成する方法をとることもできます。

b.コンテンツ データベースを Office SharePoint Server 2007 ファームに接続してアップグレードします。

c.コンテンツがアップグレードされたことと、Office SharePoint Server 2007 ファームが正常に動作していることを確認します。

**3.第 2 段階のアップグレード: コンテンツを SharePoint Server 2010 にアップグレードする**

a.コンテンツ データベースを Office SharePoint Server 2007 ファームから切断します。

b.コンテンツ データベースを SharePoint Server 2010 ファームに接続してアップグレードします (必要な場合は並列アップグレードもできます)。

c.コンテンツがアップグレードされたことと、SharePoint Server 2010 ファームが正常に動作していることを確認します。

**4.SharePoint Server 2010 ファームで要求の受け付けを開始する**
