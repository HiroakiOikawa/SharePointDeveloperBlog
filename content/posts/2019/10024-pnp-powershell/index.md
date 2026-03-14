---
title: "モダンサイトのテンプレート展開などを実現する「PnP PowerShell」"
description: "PnP PowerShell とは モダンサイトやリストの自動展開や各種設定を SharePoint 管理コンソールよりも簡単に実施できるようにするためのコマンドレットを多数備えた、PowerShell コマンドライブラリです。 Share…"
date: 2019-12-22T13:28:59+09:00
slug: "10024-pnp-powershell"
categories: ["Office 365", "SharePoint 2016", "インストールと設定、管理"]
tags: ["PnP", "PowerShell", "SharePoint", "テンプレート", "自動化"]
aliases: ["/article/10024/"]
draft: false
---
# PnP PowerShell とは

モダンサイトやリストの自動展開や各種設定を SharePoint 管理コンソールよりも簡単に実施できるようにするためのコマンドレットを多数備えた、PowerShell コマンドライブラリです。
SharePoint Online だけでなく SharePoint オンプレミスに対しても使用することができます。
詳細は [docs](https://docs.microsoft.com/ja-jp/powershell/sharepoint/sharepoint-pnp/sharepoint-pnp-cmdlets?view=sharepoint-ps) を参照してください。

# どんなことができるの？

PnP PowerShell を使うことで、例えば次のようなことができるようになります。

## モダンサイトのテンプレート展開

モダンサイトはテンプレート化することができませんが、PnP PowerShell のプロビジョニングテンプレートを使用することで、予め定めたリストやライブラリを追加したり、ドキュメントを事前にアップロードしてサイトを展開するというようなことができるようになります。
旧来のサイトテンプレートと全く同じではありませんが、サイトテンプレートよりも細かいことまで含めてできるようになります。

## 各種設定のコマンドでの実行

テナントの設定、サイトやリストの設定、権限の設定などなど、通常はブラウザから行うような操作や、ブラウザから行えないような裏の設定を、PowerShell で行えるようになります。
SharePoint 管理コンソールでももちろん同じようなことができますが、PnP PowerShell を使った方がより直感的なコマンドレットがたくさん用意されているため、少ないコード量で済ませることができます。
これにより日々の運用作業を自動化することができるようになるため、繰り返し作業の効率化、品質アップにつながります。

# まとめ

他にも色々できることがあるので、ぜひ一度 [docs](https://docs.microsoft.com/ja-jp/powershell/sharepoint/sharepoint-pnp/sharepoint-pnp-cmdlets?view=sharepoint-ps) を参照してみてください。
このブログでも PnP PowerShell を使うことを前提にした記事があったりするので、まだインストールしていない方はぜひインストールしてみてください。
[AdSense-B]
