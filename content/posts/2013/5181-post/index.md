---
title: "ドキュメントライブラリにファイルをアップロードする"
description: "C# を使ってドキュメントライブラリにファイルをアップロードするには、WebClient クラスを使うのが手軽です。 3 行目は Windows にログインしているユーザーの情報を使って SharePoint にログインすることを示していま…"
date: 2013-03-10T01:23:10+09:00
slug: "5181-post"
categories: ["SharePoint 2007", "SharePoint 2010", "SharePoint 2013", "開発とプログラミング"]
aliases: ["/article/5181/"]
draft: false
---
C# を使ってドキュメントライブラリにファイルをアップロードするには、WebClient クラスを使うのが手軽です。
```
using (WebClient client = new WebClient())
{
client.UseDefaultCredentials = true;
client.UploadFile(url, "PUT", filename);
}
```
3 行目は Windows にログインしているユーザーの情報を使って SharePoint にログインすることを示しています。
4 行目は url で指定されたドキュメントライブラリに、filename で指定されたファイルを PUT でアップロードすることを示しています。
PUT でのアップロードになるので、サーバー側は WebDAV アクセスを受信できるようにしておく必要があります。
