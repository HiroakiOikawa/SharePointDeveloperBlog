---
title: "サービスアプリケーションプロキシとサービスアプリケーションを削除する"
description: "サービスアプリケーションプロキシとサービスアプリケーションを削除するPowerSellスクリプトです。"
date: 2010-03-14T02:01:10+09:00
slug: "3981-post"
categories: ["SharePoint 2010", "インストールと設定、管理"]
aliases: ["/article/3981/"]
draft: false
---
サービスアプリケーションプロキシとサービスアプリケーションを削除するPowerSellスクリプトです。

例として、State Serviceサービスアプリケーションプロキシとサービスアプリケーションを削除します。

```
1: #削除対象サービスアプリケーションプロキシのIDを取得する
```
```
2: #赤太字の部分が削除対象サービスアプリケーションプロキシのID
```
```
3: PS C:UsersAdministrator> get-spserviceapplicationproxy
```
```
4:  
```
```
5: TypeName : State Service プロキシ
```
```
6: ApplicationName :
```
```
7: ApplicationId :
```
```
8: CanIssueNewSession : False
```
```
9: ManageLink :
```
```
10: PropertiesLink :
```
```
11: CanUpgrade : True
```
```
12: IsBackwardsCompatible : True
```
```
13: NeedsUpgradeIncludeChildren : False
```
```
14: NeedsUpgrade : False
```
```
15: UpgradeContext : Microsoft.SharePoint.Upgrade.SPUpgradeContext
```
```
16: Name : State Service
```
```
17: DisplayName : State Service
```
```
18: Id : 11b6dfde-205b-4caa-be7f-d0bf1ccc06a2
```
```
19: Status : Online
```
```
20: Parent : StateServiceProxy
```
```
21: Version : 4305
```
```
22: Properties : {}
```
```
23: Farm : SPFarm Name=SharePoint\_Config
```
```
24: UpgradedPersistedProperties : {}
```
```
25:  
```
```
26: #サービスアプリケーションプロキシを削除する
```
```
27: #先ほど取得したIDをidentityパラメータに渡す
```
```
28: PS C:UsersAdministrator> remove-spserviceapplicationproxy -identity 11b6dfde-05b-4caa-be7f-d0bf1ccc06a2
```
```
29:  
```
```
30: 確認
```
```
31: この操作を実行しますか?
```
```
32: 対象 "StateServiceApplicationProxy Name=State Service" に対して操作"Remove-SPServiceApplicationProxy"を実行しています。
```
```
33: [Y] はい(Y) [A] すべて続行(A) [N] いいえ(N) [L] すべて無視(L) [S] 中断(S)
```
```
34: [?] ヘルプ(既定値は "Y"): y
```
```
35:  
```
```
36: #削除対象サービスアプリケーションのIDを取得する
```
```
37: #赤太字の部分が削除対象サービスアプリケーションのID
```
```
38: PS C:UsersAdministrator> get-spserviceapplication
```
```
39:  
```
```
40: DisplayName TypeName Id
```
```
41: ----------- -------- --
```
```
42: State Service State Service 96e7030a-eac3-4d62-ae1d-dce878295b30
```
```
43: Security Token Se... Security Token Se... e0895169-e449-4aec-92fb-8ac63cba3428
```
```
44: Application Disco... Application Disco... 38c33d18-2ec1-4c57-8ff7-934067a794e7
```
```
45: Word Automation S... Word Automation S... 482775e8-4084-4dd7-ada7-3278aedfa478
```
```
46:  
```
```
47: #サービスアプリケーションを削除する
```
```
48: #先ほど取得したIDをidentityパラメータに渡す
```
```
49: PS C:UsersAdministrator> remove-spserviceapplication -identity 96e7030a-eac3-d62-ae1d-dce878295b30
```
```
50:  
```
```
51: 確認
```
```
52: この操作を実行しますか?
```
```
53: 対象 "StateServiceApplication Name=State Service" に対して操作"Remove-SPServiceApplication" を実行しています。
```
```
54: [Y] はい(Y) [A] すべて続行(A) [N] いいえ(N) [L] すべて無視(L) [S] 中断(S)
```
```
55: [?] ヘルプ(既定値は "Y"): y
```
