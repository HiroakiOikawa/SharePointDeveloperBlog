---
title: "カスタムフィールドの JSLink プロパティに指定した JS を変更しても反映されない場合の対処法"
description: "カスタムフィールドで JSLink を使う場合に、SPField.JSLink プロパティで指定した JavaScript ファイルがキャッシュされてしまい、JavaScript を変更しても変更内容が反映されないという状況が起きたので、そ…"
date: 2015-01-26T16:19:42+09:00
slug: "9593-jslink-js"
categories: ["SharePoint 2013", "開発とプログラミング"]
aliases: ["/article/9593/"]
draft: false
---
カスタムフィールドで JSLink を使う場合に、SPField.JSLink プロパティで指定した JavaScript ファイルがキャッシュされてしまい、JavaScript を変更しても変更内容が反映されないという状況が起きたので、その場合の対処方法を記載します。
ちなみに、以下の条件下以外で JSLink を使ったことがないので、JavaScript ファイルがキャッシュされること自体が普通に起きることなのかどうかは未確認です。
今回開発したカスタムフィールでの JSLink 周りの状態は以下の通り。

- JSLink プロパティで指定した JavaScript ファイルは、Layouts フォルダ配下の自前のフォルダに配置。
- ダウンロード最小化戦略フィーチャーはアクティブ状態。
- JavaScript ファイル内で、RegisterModuleInit 関数で JavaScript ファイルを登録する処理を実行。

**対処方法**
Visual Studio のデバッグ実行の最中に、カスタムフィールドをリストから一度削除しもう一度付け直すことで、変更後の JavaScript が実行されることを確認しました。
なお、ブラウザの履歴削除や Ctrl+F5、iireset コマンドの実行ではダメでした。
