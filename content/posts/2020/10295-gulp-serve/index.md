---
title: "gulp serve でエラーが出た時の対応"
description: "SharePoint Framework 開発中、gulp serve でエラーが発生することがありますが、実際に発生したエラーと対処法をこの記事にまとめています。"
date: 2020-07-20T10:00:40+09:00
slug: "10295-gulp-serve"
categories: ["Office 365", "SharePoint", "開発とプログラミング"]
tags: ["gulp", "M365Dev", "SharePoint", "SPFx"]
aliases: ["/article/10295/"]
draft: false
---
最終更新日：2020/07/26

# はじめに

SharePoint Framework 開発中、gulp serve でエラーが発生することがありますが、実際に発生したエラーと対処法をこの記事にまとめていきたいと思います。

# エラーケース

## ケース１：dist フォルダの権限エラー

**■エラーメッセージ（下線箇所は状況により異なります）**Error - Unknown
EPERM: operation not permitted, chmod '/usr/app/spfx/dist/*link-list-web-part-web-part.js*'
**■対処法**/usr/app/spfx/dist フォルダにあるファイルへのアクセスができないために発生しているものと思われます。
プロジェクト作業フォルダ内の dist フォルダを削除して再度 gulp serve を実施してください。

## ケース２：lib フォルダの権限エラー

**■エラーメッセージ（下線箇所は状況により異なります）**Error - 'copy-static-assets' sub task errored after 90 ms
EPERM: operation not permitted, chmod '/usr/app/spfx/lib/*webparts/linkListWebPart/LinkListWebPartWebPart.manifest.json*'
**■対処法**/usr/app/spfx/lib フォルダにあるファイルへのアクセスができないために発生しているものと思われます。
プロジェクト作業フォルダ内の lib フォルダを削除して再度 gulp serve を実施してください。

## ケース３：Strings クラスのプロパティが見つからないエラー

**■エラーメッセージ（下線箇所は状況により異なります）**[tsc] src/webparts/*linkListWebPart/LinkListWebPartWebPart.ts(59,34)*: error TS2339: Property '*SourceSiteUrl*' does not exist on type '*ILinkListWebPartWebPartStrings*'.
**■対処法**Strings クラスは、src/webparts/*linkListWebPart*/loc フォルダ内の mystrings.d.ts から自動生成されるクラスです。
従って、mystrings.d.ts 内に該当のプロパティが定義されていないと上記のようなエラーになるのですが、プロパティを定義していて VSCode 上では文法エラーが出ていないにも関わらず、gulp serve をすると上記のエラーが発生することがあります。
その場合は、mystrings.d.ts からのクラス生成が正しく行われていない可能性があるので、mystrings.d.ts を一度適当に変更して gulp build を行った後、改めて正しい状態に戻してから、gulp build か gulp serve をしてください。
[AdSense-B]
