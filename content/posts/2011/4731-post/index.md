---
title: "インストール時の必須コンポーネントを事前にダウンロードするスクリプト"
description: "SharePoint2010のインストールは、大量の必須コンポーネントをSharePoint本体のインストールに先駆けてインストールしないといけないのはご存じのとおり。 そのために、サーバー機をインターネットにつなぎ、必須コンポーネントのイ…"
date: 2011-12-25T11:09:12+09:00
slug: "4731-post"
categories: ["SharePoint 2010", "インストールと設定、管理"]
aliases: ["/article/4731/"]
draft: false
---
SharePoint2010のインストールは、大量の必須コンポーネントをSharePoint本体のインストールに先駆けてインストールしないといけないのはご存じのとおり。
そのために、サーバー機をインターネットにつなぎ、必須コンポーネントのインストールを実行するわけですが、サーバー機を一瞬でもインターネットにつながないといけないというのが、場合によってはNGなことってありますよね。
そんな時はこのスクリプトを使うといいと思います。
<http://blogs.technet.com/b/tothesharepoint/archive/2011/12/19/windows-powershell-script-download-sharepoint-2010-pre-requisites.aspx>
必須コンポーネントを全部ダウンロードしてくれるPowerShellなので、別のPCであらかじめダウンロードしておくことができますよ。
