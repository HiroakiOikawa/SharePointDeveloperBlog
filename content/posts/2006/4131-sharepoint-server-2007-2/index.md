---
title: "SharePoint Server 2007 ベータ2 のインストール手順"
description: "MOSSベータ２をVirtualPC環境にインストールしてみました。そのときの手順です。"
date: 2006-08-27T09:41:13+09:00
slug: "4131-sharepoint-server-2007-2"
categories: ["SharePoint 2007", "インストールと設定、管理"]
aliases: ["/article/4131/"]
draft: false
---
※この記事はSharePoint Server 2007 ベータ２を対象としているため、製品版とは異なる場合があります。

MOSSベータ２をVirtualPC環境にインストールしてみました。
そのときの手順です。

なお、今回は1台のサーバーにすべてインストール場合の手順です。
また、企業で使うことを想定しているので、DBはデスクトップエンジンではなくSQLServer2005にします。
**インストール先のマシンのソフトウェア構成**
・OSはWindows Server 2003 R2
・「サーバーの役割管理」でアプリケーションサーバとして構成済み
・SQL Server 2005
・.NET Framework 2.0 Runtimeおよび日本語ランゲージパック
→SQL Server 2005をインストールすると一緒に入ります。
・Windows Workflow Foundation ベータ2
**インストール手順**
**1. MOSS2007のCDをドライブにセット。**インストーラが起動します。
自動的にインストーラが起動しない場合は、setup.cmdを実行。
**2.プロダクトキーを入力します。**
プロダクトキーは、ベータ2のケースに書いてあります。 
**3.ライセンス条項に同意します。**
**4.インストールの種類を選択します。**
今回はDBにSQLServer2005を使用したいので、「詳細設定」を選択。 
**5.サーバーの種類を選択します。**
DBはすでにSQLServer2005がインストール済みで、1台のサーバーにすべて
インストールしたいので、「完全」を選択。 
**6.ファイルの場所を指定します。**
まぁ、適当に・・・ 
**7.フィードバックを選択します。**
なるべくMSに協力しましょう。せっかくベータ版を使うわけですし。
なので、「はい」を選択。 
**8.「今すぐインストール」をクリック。**
インストールが始まります。 
**9.インストールが完了したら**
「SharePoint 製品とテクノロジ構成ウィザードを今すぐ実行する」の
チェックを付けるか、外すかして、閉じるをクリック。 
これでインストール完了です！
インストール作業はとっても簡単です。

**参考**
Windows Workflow Foundation(WWF)のインストール
WWFは以下の場所からセットアップファイルを取得してください。
<http://www.microsoft.com/downloads/details.aspx?FamilyId=5C080096-F3A0-4CE4-8830-1489D0215877&displaylang=en>

ページ内にある「Files in This Download」の
「Windows Workflow Foundation Runtime Components Beta 2\_2(EN) for x86.exe」
をダウンロードし、実行してください。
インストールは、インストーラのいうとおりにするだけでＯＫです。
