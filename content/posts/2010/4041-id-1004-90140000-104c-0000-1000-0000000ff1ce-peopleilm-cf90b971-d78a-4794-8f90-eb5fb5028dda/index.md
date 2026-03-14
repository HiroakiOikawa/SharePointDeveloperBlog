---
title: "イベントID:1004 製品 '{90140000-104C-0000-1000-0000000FF1CE}'、機能 'PeopleILM'、コンポーネント '{CF90B971-D78A-4794-8F90-EB5FB5028DDA}' の検出に失敗しました。"
description: "イベントログに記録される、イベントID:1004に対する対応方法です。"
date: 2010-11-14T02:35:04+09:00
slug: "4041-id-1004-90140000-104c-0000-1000-0000000ff1ce-peopleilm-cf90b971-d78a-4794-8f90-eb5fb5028dda"
categories: ["SharePoint 2010", "全般"]
aliases: ["/article/4041/"]
draft: false
---
イベントログに記録される、イベントID:1004に対する対応方法です。

**イベント内容**

|  |  |
| --- | --- |
| ログの名前 | アプリケーション​ |
| ソース | MsiInstaller​ |
| イベントID | 1004 |
| レベル | 警告 |

​
**メッセージ**※以下のようなメッセージが表示されます。
製品 '{90140000-104C-0000-1000-0000000FF1CE}'、機能 'PeopleILM'、コンポーネント '{1C12B6E6-898C-4D58-9774-AAAFBDFE273C}' の検出に失敗しました。リソース 'C:Program FilesMicrosoft Office Servers14.0ServiceMicrosoft.ResourceManagement.Service.exe' がありません。
製品 '{90140000-104C-0000-1000-0000000FF1CE}'、機能 'PeopleILM'、コンポーネント '{CF90B971-D78A-4794-8F90-EB5FB5028DDA}' の検出に失敗しました。リソース 'C:Program FilesMicrosoft Office Servers14.0SQLDatabaseSettings.sql' がありません。

製品 '{90140000-104C-0000-1000-0000000FF1CE}'、機能 'PeopleILM'、コンポーネント '{1AE472A9-E94A-41DC-9E98-F89A2821658F}' の検出に失敗しました。リソース 'C:Program FilesMicrosoft Office Servers14.0Toolsmakecert.exe' がありません。

また、このイベントログが記録されるトリガーが、プロファイル同期の手動実行や同期接続の構成になります。
これらの操作を行った際に、SharePointの画面上は「MOSS MA not found」というエラーメッセージが表示されます。

**対応方法**このエラーは、ユーザープロファイルの同期を実行する際に発生するエラーのようです。
イベントログの「ユーザー 」に記録されているユーザーが、上記ファイルにアクセスできずに見つからないといった感じのエラーになっていると思われます。
そのため、上記の３つのフォルダ（Service, SQL, Tools)に対して「読み取りと実行」アクセス権を付与することで、問題が解消します。
