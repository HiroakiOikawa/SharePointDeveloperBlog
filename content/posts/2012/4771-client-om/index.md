---
title: "匿名アクセス時の Client OM の制限解除方法"
description: "Client OM を使って匿名アクセスをする場合、利用できるメソッドに制限があります。"
date: 2012-10-22T12:48:42+09:00
slug: "4771-client-om"
categories: ["SharePoint 2010", "開発とプログラミング"]
aliases: ["/article/4771/"]
draft: false
---
Client OM を使って匿名アクセスをする場合、利用できるメソッドに制限があります。

例えば標準状態では、以下のコードは22行目を実行するとエラーとなります。

```
1: ClientContext ctx = new ClientContext("http://hoge");
```
```
2: ctx.AuthenticationMode = ClientAuthenticationMode.Anonymous;
```
```
3: List list = ctx.Web.Lists.GetByTitle("Sample");
```
```
4:  
```
```
5: CamlQuery query = new CamlQuery();
```
```
6: query.ViewXml =
```
```
7: "<View>" +
```
```
8: "<Query>" +
```
```
9: "<Where>" +
```
```
10: "<Eq>" +
```
```
11: "<FieldRef Name='\_ModerationStatus' />" +
```
```
12: "<Value Type='ModStat'>0</Value>" +
```
```
13: "</Eq>" +
```
```
14: "</Where>" +
```
```
15: "</Query>" +
```
```
16: "</View>";
```
```
17:  
```
```
18: ListItemCollection itemColl = list.GetItems(query);
```
```
19:  
```
```
20: ctx.Load(itemColl);
```
```
21: ctx.Load(itemColl, items => items.Include(item => item["Title"]));
```
```
22: ctx.ExecuteQuery();
```

エラーの内容は以下の通り。

Microsoft.SharePoint.Client.ServerException: 種類 "List"、ID "{d89f0b18-614e-4b4a-bac0-fd6142b55448}" のメソッド "GetItems" は、サーバーで管理者によってブロックされています。

GetItems メソッドの使用が管理者によりブロックされているとのこと。

このブロックを解除することで GetItems メソッドが使えるようになります。

では、どこでブロックの設定がされているのかというと、SPWebApplication.ClientCallableSettings プロパティになります。

このプロパティでは Client OM 利用時の制限事項がいくつか定義されており、その中で匿名アクセスに関するものが、ClientCallableSettings.AnonymousRestrictedTypes で設定されています。

まずは、ClientCallableSettings.AnonymousRestrictedTypes の初期状態を見てみます。

以下の PowerShell スクリプトを実行します。

```
1: $w = Get-SPWebApplication “http://hoge/”
```
```
2: $w.ClientCallableSettings.AnonymousRestrictedTypes
```

実行結果は以下のようになります。

```
1: FullName : Microsoft.SharePoint.SPList
```
```
2: MethodNames : {GetItems, GetChanges}
```
```
3: GetPropertyNames : {}
```
```
4: SetPropertyNames : {}
```
```
5: UpgradedPersistedProperties :
```
```
6:  
```
```
7: FullName : Microsoft.SharePoint.SPWeb
```
```
8: MethodNames : {GetChanges, GetSubwebsForCurrentUser}
```
```
9: GetPropertyNames : {}
```
```
10: SetPropertyNames : {}
```
```
11: UpgradedPersistedProperties :
```
```
12:  
```
```
13: FullName : Microsoft.SharePoint.SPSite
```
```
14: MethodNames : {GetChanges}
```
```
15: GetPropertyNames : {}
```
```
16: SetPropertyNames : {}
```
```
17: UpgradedPersistedProperties :
```

これを見ると、2行目で SPList.GetItems メソッドが制限されていることがわかります。

他にも、SPSite、SPWeb でも制限されているメソッドがあるようです。

では次に、制限の解除をしたいと思います。

先ほどのスクリプトの続きで、以下の PowerShell スクリプトを実行します。

```
1: $w.ClientCallableSettings.AnonymousRestrictedTypes.Remove([microsoft.sharepoint.splist], "GetItems")
```
```
2: $w.Update()
```

うんともすんとも言いませんが、上記スクリプト実行後にもう一度 ClientCallableSettings.AnonymousRestrictedTypes を出力してみると、 上記出力結果の2行目にあった GetItems がなくなっていることが確認できます。

```
1: FullName : Microsoft.SharePoint.SPList
```
```
2: MethodNames : {GetChanges}
```
```
3: GetPropertyNames : {}
```
```
4: SetPropertyNames : {}
```
```
5: UpgradedPersistedProperties : {}
```
```
6:  
```
```
7: FullName : Microsoft.SharePoint.SPWeb
```
```
8: MethodNames : {GetChanges, GetSubwebsForCurrentUser}
```
```
9: GetPropertyNames : {}
```
```
10: SetPropertyNames : {}
```
```
11: UpgradedPersistedProperties : {}
```
```
12:  
```
```
13: FullName : Microsoft.SharePoint.SPSite
```
```
14: MethodNames : {GetChanges}
```
```
15: GetPropertyNames : {}
```
```
16: SetPropertyNames : {}
```
```
17: UpgradedPersistedProperties : {}
```

これで設定完了です。

一番最初に書いたプログラムを実行すると、今度はエラーは出ず無事アイテムを取得できるはずです。

参考情報：

MSDN Blog
<http://blogs.msdn.com/b/bobgerman/archive/2012/01/10/anonymous-client-access-to-sharepoint-2010.aspx>

Will Code for Nuts
[http://www.codefornuts.com/2010/05/anonymously-accessing-list-items.html](http://www.codefornuts.com/2010/05/anonymously-accessing-list-items.html "http://www.codefornuts.com/2010/05/anonymously-accessing-list-items.html")
