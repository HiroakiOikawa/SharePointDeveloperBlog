---
title: "Graph API で定期予定の一連の予定を取得する"
description: "Microsoft Graph APIでseriesMasterIdを使ってcalendarViewから定期予定を取得できなくなったので代わりの方法を調べてみた。"
date: 2025-02-09T01:25:39+09:00
slug: "10745-graph-api"
categories: ["Office 開発"]
tags: ["calendarView", "event", "GraphApi", "outlook"]
aliases: ["/article/10745/"]
draft: false
---
## はじめに

Microsoft Graph API で、Outlook 予定表に登録した定期予定について、その定期予定の一連の予定を取得する方法についてのメモです。

## calendarView で seriesMasterId でのクエリが使えなくなった！？

少なくとも2024年のころは以下のクエリで定期予定の一連の予定を取得することができてました。

```
https://graph.microsoft.com/v1.0/users/メールアドレス/calendarView?startDateTime=開始日時&endDateTime=$終了日時&filter=seriesMasterId eq シリーズマスターのID
```

ところが2025年に入ってからかもう少し経ってからか、上記クエリが結果を返さなくなりました・・・
特段そのような変更のアナウンスは無かった気はするのですが、2025年2月時点でも上記クエリでは期待した結果は得られない状態になっています。

## 代替案

他にやり方がないものかとネットを調べていたら、昔の情報ですが困った時の stack overflow に良いものがありました。
<https://stackoverflow.com/questions/51676962/microsoft-graph-filter-calendarview-by-seriesmasterid>

instances を利用するというもの。
instances は使ったことがないので docs で調べてみたところ確かに良さそうです。
<https://learn.microsoft.com/ja-jp/graph/api/event-list-instances?view=graph-rest-1.0&tabs=http>

というか、、seriesMasterId を使うのではなく最初からこれ使っておきなさい、という話ですね。

```
https://graph.microsoft.com/v1.0/users/メールアドレス/events/シリーズマスタのID/instances?startDateTime=開始日時&endDateTime=終了日時
```

なので、代替案ではなく、これが正解かなと思います。これで定期予定の一覧の予定アイテムを取得することができました！
