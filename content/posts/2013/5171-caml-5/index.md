---
title: "CAML クエリーで今日や今日から 5 日前の日を指定する"
description: "CAML クエリーで、「締切日が今日以前」や「締切日が今日より 5 日前」という条件を指定する場合、今日という変数は Today タグで指定します。 また、Today タグの OffsetDays 属性で 5 日前とか 3 日後といった +…"
date: 2013-03-10T00:31:05+09:00
slug: "5171-caml-5"
categories: ["Office 365", "SharePoint 2007", "SharePoint 2010", "SharePoint 2013", "開発とプログラミング"]
aliases: ["/article/5171/"]
draft: false
---
CAML クエリーで、「締切日が今日以前」や「締切日が今日より 5 日前」という条件を指定する場合、今日という変数は Today タグで指定します。
また、Today タグの OffsetDays 属性で 5 日前とか 3 日後といった +- の日付を指定します。
例：締切日が今日以前

```
1: <Query>
```
```
2: <Where>
```
```
3: <Leq>
```
```
4: <FieldRef Name="DueDate" />
```
```
5: <Value Type="DateTime">
```
```
6: <Today />
```
```
7: </Value>
```
```
8: </Leq>
```
```
9: </Where>
```
```
10: </Query>
```

 
例：締切日が今日より5日前

```
1: <Query>
```
```
2: <Where>
```
```
3: <Lt>
```
```
4: <FieldRef Name="DueDate" />
```
```
5: <Value Type="DateTime">
```
```
6: <Today OffsetDays="-5" />
```
```
7: </Value>
```
```
8: </Lt>
```
```
9: </Where>
```
```
10: </Query>
```

 
なお、TechNet にも Today タグの説明が載っていますが、2013/3/10 現在、オフセットを指定する属性に間違いがあります。
TechNet 上は "OffsetDays" ではなく、"Offset" となっています。
試しに "Offset" と書いてみましたが、正しく動作しませんでした。
TechNet : Today 要素(クエリ)
[http://technet.microsoft.com/ja-jp/subscriptions/ms460496.aspx](http://technet.microsoft.com/ja-jp/subscriptions/ms460496.aspx "http://technet.microsoft.com/ja-jp/subscriptions/ms460496.aspx")
