---
title: "SharePoint Server 2007 Beta2 Technical Refresh のインストール"
description: "製品版出荷前の最後の公開リリースになるかもしれない、Beta 2 TRが先日ついにリリースされました。 日本ではあまり大々的に取り上げられていないけど、これを待ち望んでいた人は多いはず。 自分もそのうちの一人で、MOSSの検証をしていていく…"
date: 2009-09-30T10:24:57+09:00
slug: "4321-sharepoint-server-2007-beta2-technical-refresh"
categories: ["SharePoint 2007", "インストールと設定、管理"]
aliases: ["/article/4321/"]
draft: false
---
製品版出荷前の最後の公開リリースになるかもしれない、Beta 2 TRが先日ついにリリースされました。
日本ではあまり大々的に取り上げられていないけど、これを待ち望んでいた人は多いはず。
自分もそのうちの一人で、MOSSの検証をしていていくつかうまくいかない機能とかがあったので早くTRで試したいと思ってました。
ということで、早速ダウンロードしてインストールしてみたので、まずはファイルのダウンロードから、MOSSへ適用するまでの手順をめもります。
インストール手順書が米MSサイトにあります。
いろいろなパターンに対応した手順が書いてありますが、どれもかなりめんどくさい手順になっています。
正直ちょっとやる気なくします・・・
<http://www.microsoft.com/downloads/details.aspx?displaylang=ja&FamilyID=920B9690-B835-4785-A771-188C2082B2BC>
**前提条件**今回beta2 TRをインストールする環境は、すでにbeta2がインストール済みです。
インストール手順書でいうところの、「既存の Beta2 環境を Beta 2 Technical Refresh にアップグレードする方法」なります。
**１．ダウンロード**
以下のURLからWSSとSharePointServerそれぞれダウンロードします。
Windows SharePoint Services 3.0(WSS)
<http://www.microsoft.com/downloads/details.aspx?displaylang=ja&FamilyID=e1e51280-71f0-4d60-b2b9-3c49df916bc2>
SharePoint Server 2007
<http://www.microsoft.com/downloads/details.aspx?displaylang=ja&FamilyID=0b6bd175-e700-44b8-ab47-e4459250d16d>
**２．Windows Workflow Foundationをアンインストール**
MOSS beta2をインストールする前に入れたWindows Workflow Foundationをプログラムの追加と削除から、アンインストールします。
**３．.NET Framework 3.0 Release Candidateをインストール**
以下のサイトから.NET Framework 3.0 Release Candidateをダウンロードしてインストールします。
<http://www.microsoft.com/downloads/details.aspx?displaylang=ja&FamilyID=19E21845-F5E3-4387-95FF-66788825C1AF>
インストールはライセンス条項に同意して、インストールボタンをクリックするだけなので、画面キャプチャなどは割愛します。
インストール完了後に再起動します。
※インストールの最後に、Windows Communication Foundationのパッチをインストールするよう指示があるので、こちらも念のためインストールしておいたほうが良いでしょう。
リリースノートを見る限りでは必要ない気もしますが・・・
**４．SharePointの検索サービスを停止**
以下の２つのサービスを停止します。
・Windows SharePoint Services Search
・Office SharePoint Server Search
**５．WindowsSharePointServices 3.0 Beta2 TRのインストール**
**５．１．インストール開始**
ダウンロードしたファイルを実行します。
**５．２．ライセンス条項**
ライセンス条項に同意するをチェックして、[次へ]をクリック。
**５．３．SharePoint関連サービスを停止に関するメッセージ**
Beta2 TR へのアップグレードによりInternet Information Services、SharePoint Administration Services、SharePoint Timer Serviceが再起動されるとのメッセージが表示されます。
[はい]をクリック。
**５．４．ファイル展開、インストール**
ファイルが展開されて、そのままインストールが始まります。
インストールが完了するまでしばらくかかります。
**５．５．通知**他にもBeta2 TRのインストールをする必要があることをわざわざ教えてくれます。
[OK]をクリック。
**５．６．完了**
インストール完了メッセージが表示され、WSS Beta2TRのインストール完了。
**６．SharePoint Server 2007 Beta2 TRのインストール**
**６．１．インストール開始**
ダウンロードしたファイルを実行します。
**６．２．ライセンス条項**
ライセンス条項に同意するをチェックして、[次へ]をクリック。
**６．３．SharePoint関連サービスを停止に関するメッセージ**Beta2 TR へのアップグレードによりInternet Information Services、SharePoint Administration Services、SharePoint Timer Serviceが再起動されるとのメッセージが表示されます。
[はい]をクリック。
**６．４．ファイル展開、インストール**
ファイルが展開されて、そのままインストールが始まります。
インストールが完了するまでWSSよりも時間がかかります。
**６．５．完了**
インストール完了メッセージが表示され、SharePoint Server 2007 Beta2TRのインストール完了。
**６．６．アップグレード開始**
インストールが完了すると自動的にSharePoint 製品とテクノロジ構成ウィザードが起動します。
指示に従いアップグレードプロセスを開始すると、アップグレードが行われます。
**６．７．アップグレード完了**
アップグレードプロセスが完了すると、自動的に管理サイトが起動します。
これでアップグレード完了です。
**注意**
今回、Beta2で作成済みのサイトをBeta2TRにアップグレードする方法を実験しましたが、アップグレード後に発覚した問題が２つあります。
１．
上記手順の６．７のあと、自動的に管理サイトが起動しますが、この起動が失敗しました。
とりあえずもう一度管理サイトへ移動してみると、管理サイトのホームエリアにあるWebパーツのひとつがエラーで表示できなくなっていました。
コレが原因？
２．
Beta2TRから、Webアプリケーションのアプリケーションプールを実行するユーザーに、ローカルシステムとローカルサービスが使用できなくなったようです。
そのため、Beta2のころにこれらのユーザーで作成したWebアプリケーションがあると、Beta2TRにした途端に動かなくなってしまいます。
この際に発生したエラーは、「構成データベースに接続できませんでした。」という内容でした。
アプリケーションプールのユーザーをネットワークサービスとか、ドメインユーザーとかに変更したら動くようになりました。
