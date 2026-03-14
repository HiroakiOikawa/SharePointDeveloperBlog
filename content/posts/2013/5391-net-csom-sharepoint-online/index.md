---
title: ".NET CSOM による SharePoint Online への接続"
description: ".NET 版の Client Side Object Model を使って SharePoint Online に接続するためのサンプルコードをご紹介します。"
date: 2013-08-26T11:07:18+09:00
slug: "5391-net-csom-sharepoint-online"
categories: ["Office 365", "開発とプログラミング"]
aliases: ["/article/5391/"]
draft: false
---
### はじめに

.NET 版の Client Side Object Model を使って SharePoint Online に接続するためのサンプルコードをご紹介します。

### サンプルコード

以下は、SharePoint Online に接続するための部分的なコードになります。

```
1: SecureString securePassword = new SecureString();
```
```
2: foreach (char passwordChar in password)
```
```
3: {
```
```
4: securePassword.AppendChar(passwordChar);
```
```
5: }
```
```
6:  
```
```
7: ClientContext context = new ClientContext(siteUrl);
```
```
8: context.Credentials =
```
```
9: new SharePointOnlineCredentials(accountName, securePassword);
```

### サンプルコードの説明

１行目の [SecureString](http://msdn.microsoft.com/ja-jp/library/system.security.securestring.aspx) というクラスは、.NET でパスワードなどセキュアな文字列情報を扱うためのクラスで、SharePoint Online へ接続するためのパスワードを格納するために使っています。
SecureString への値の格納は少々面倒なのですが、２行目から５行目の部分で行っています。
この例では、password という string 型の変数にユーザーが指定した SharePoint Online へのパスワードが格納されている前提で、securePassword という変数に１文字ずつパスワード文字列を格納しています。
７行目で SharePoint への接続を管理する [ClientContext](http://msdn.microsoft.com/ja-jp/library/office/apps/microsoft.sharepoint.client.clientcontext.aspx) クラスのインスタンス(context変数)を、接続先サイトの URL (siteUrl変数)を渡して生成しています。
８、９行目では、７行目で生成した ClientContext の Credentials プロパティに [SharePointOnlineCredentials](http://msdn.microsoft.com/ja-jp/library/office/apps/microsoft.sharepoint.client.sharepointonlinecredentials.aspx) クラスのインスタンスを渡しています。
この SharePointOnlineCredentials クラスが SharePoint Online に接続するための資格情報などを持っており、これを使うことで SharePoint Online に接続することができるようになります。
資格情報として、ログインに使用するアカウント名(accountName変数)と、パスワード(securePassword変数)を指定しています。
これらは、SharePoint Online のログインページで入力しているものと同じものになります。

### 注意事項

- コードを利用する際には、必要な名前空間の指定など、適宜行ってください。
- あくまでもサンプルですので、実際に開発されるプログラムに合わせて、適宜変更してご利用ください。
