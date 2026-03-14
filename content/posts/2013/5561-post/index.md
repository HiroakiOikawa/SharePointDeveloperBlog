---
title: "ファームで使用しているデータベースを一覧表示する"
description: "はじめに 開発環境や検証環境として、SharePointファームをたくさん立てていると、いつの間にかデータベースがたくさんできてしまい、いざデータベースを整理しようと思った時にどのデータベースを消してよいのかが判別できなくなることがあると思…"
date: 2013-11-09T10:06:26+09:00
slug: "5561-post"
categories: ["SharePoint 2010", "SharePoint 2013", "インストールと設定、管理"]
aliases: ["/article/5561/"]
draft: false
---
### はじめに

開発環境や検証環境として、SharePointファームをたくさん立てていると、いつの間にかデータベースがたくさんできてしまい、いざデータベースを整理しようと思った時にどのデータベースを消してよいのかが判別できなくなることがあると思います（私だけ！？）
SQL Server Management Studioのオブジェクトエクスプローラを見ると、データベースが多すぎてどうしたらよいものかと・・・
![image_3_42B37651](./image_3_42B37651.png)
※画像はあえて小さくして載せてます。
そんな時にファームで利用しているデータベースの一覧が見れるととても便利なわけですが、PowerShell で手軽に実現できてしまいます。

### データベースを一覧表示するコマンドレット

SharePointの管理シェルを立ち上げ、以下のコマンドを実行してください。
Get-SPDatabase | select Name | Sort-Object { $\_.Name }
すると以下のような結果が得られます。
※小さくて見えないと思いますが、データベース名の一覧が名前の昇順で表示されています。
![image_7_192990E2](./image_7_192990E2.png)
あとはこの一覧を片手に、SQL Server Management Studio のオブジェクトエクスプローラを見ながら、一覧に無いデータベースを探して消してよいかどうか判断しながら作業をしていくだけです。

### データベースサイズの一覧を取得するコマンドレット

ついでに、データベースサイズを含む一覧を取得するコマンドレットも紹介します。
これも何かと使いそうですよね。
Get-SPDatabase | select Name, DiskSizeRequired | Sort-Object { $\_.Name }
コマンドとしては select に [DiskSizeRequired](http://msdn.microsoft.com/ja-jp/library/microsoft.sharepoint.administration.spdatabase.disksizerequired.aspx) を追加しているだけです。
このプロパティは、実際のデータベースサイズとは異なるのですが、ざっと確認する限り実サイズとの差はそれほどないので、データベースサイズの目安にはなると思います。
