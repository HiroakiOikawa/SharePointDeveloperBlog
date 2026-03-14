---
title: "イベントID:6398 ジョブ定義 Microsoft.SharePoint.Diagnostics.SPDatabaseServerDiagnosticsPerformanceCounterProvider (ID c3af92ff-8349-4483-bab5-c29c7eb5cf9f) の Execute メソッドが例外をスローしました。"
description: "イベントログに記録される、イベントID:6398に対する対応方法です。"
date: 2011-06-21T03:58:39+09:00
slug: "4101-id-6398-microsoft-sharepoint-diagnostics-spdatabaseserverdiagnosticsperformancecounterprovider-id-c3af92ff-8349-4483-bab5-c29c7eb5cf9f-execute"
categories: ["SharePoint 2010", "全般"]
aliases: ["/article/4101/"]
draft: false
---
イベントログに記録される、イベントID:6398に対する対応方法です。

**イベント内容**

|  |  |
| --- | --- |
| ログの名前 | アプリケーション |
| ソース | Microsoft-SharePoint Products-SharePoint Foundation​ |
| イベントID |  |
| レベル | 重要 |

**レベル：​**
​重大

**メッセージ：**
※以下のようなメッセージが表示されます。
ジョブ定義 Microsoft.SharePoint.Diagnostics.SPDatabaseServerDiagnosticsPerformanceCounterProvider (ID c3af92ff-8349-4483-bab5-c29c7eb5cf9f) の Execute メソッドが例外をスローしました。詳細については、以下を参照してください。
{サーバー名}:許可されていない操作を実行しようとしました。;
          データベース サーバーが利用可能であり、 SharePoint Timer Service のアカウントがデータベース サーバーの Performance Monitor Users グループのメンバーであることを確認してください。

**対応方法**

メッセージにある通り、データベースサーバーのローカルセキュリティグループである「Performance Monitor Users」グループに、SharePoint Timer Serviceを実行しているユーザーアカウントを追加すると、問題は解消します。
