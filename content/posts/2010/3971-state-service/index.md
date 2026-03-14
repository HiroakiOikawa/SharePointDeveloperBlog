---
title: "State Service サービスアプリケーションを削除する"
description: "PowerShellでState Serviceサービスアプリケーションを削除する方法です。 １．State ServiceのDBを削除 以下のコマンドでState ServiceのDBを削除します。"
date: 2010-03-14T01:53:43+09:00
slug: "3971-state-service"
categories: ["SharePoint 2010", "インストールと設定、管理"]
aliases: ["/article/3971/"]
draft: false
---
PowerShellでState Serviceサービスアプリケーションを削除する方法です。
**１．State ServiceのDBを削除**以下のコマンドでState ServiceのDBを削除します。

```
1: #削除するState ServiceのIDを取得する
```
```
2: #赤太字が削除対象のID
```
```
3: PS C:UsersAdministrator> get-spstateservicedatabase
```
```
4:  
```
```
5: Name Id Type
```
```
6: ---- -- ----
```
```
7: StateService\_09592f64... 1c3fed71-f364-481c-9112-9b2125d4d09f Microsoft.Offi...
```
```
8:  
```
```
9: #先ほど取得したIDをidentityパラメータに渡す
```
```
10: PS C:UsersAdministrator> remove-spstateservicedatabase -identity 1c3fed71-f364-481c-9112-9b2125d4d09f
```
```
11:  
```
```
12: 確認
```
```
13: この操作を実行しますか?
```
```
14: 対象 "StateService\_09592f64711045459aa10119421ef10d" に対して操作"Remove-SPStateServiceDatabase" を実行しています。
```
```
15: [Y] はい(Y) [A] すべて続行(A) [N] いいえ(N) [L] すべて無視(L) [S] 中断(S) [?] ヘルプ(既定値は "Y"):y
```

**２．State Serviceサービスアプリケーションを削除** 
以下のリンク先の手順でState Serviceを削除します。
[http://sharepoint.orivers.jp/reference/SitePages/%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%A2%E3%83%97%E3%83%AA%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%83%97%E3%83%AD%E3%82%AD%E3%82%B7%E3%81%A8%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%A2%E3%83%97%E3%83%AA%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%82%92%E5%89%8A%E9%99%A4%E3%81%99%E3%82%8B.aspx](http://sharepoint.orivers.jp/reference/SitePages/サービスアプリケーションプロキシとサービスアプリケーションを削除する.aspx)
