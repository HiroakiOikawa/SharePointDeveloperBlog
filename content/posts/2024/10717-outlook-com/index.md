---
title: "ネストされたアプリ認証はOutlook.comではサポート対象外？"
description: "Outlook.comに読み込んだアドインでネストされたアプリ認証はサポート対象外とdocsに書かれているのですが、色々試している限りは2024年11月時点ではちょっと違うみたい？"
date: 2024-11-30T19:17:52+09:00
slug: "10717-outlook-com"
categories: ["Outlook アドイン"]
tags: ["M365Dev", "outlook", "Outlook アドイン"]
aliases: ["/article/10717/"]
draft: false
---
この記事は私の検証結果をもとにして書いています。
公式情報を元にしている訳ではないですので、その点はご了承ください。

Outlook.comに読み込んだアドインでネストされたアプリ認証はサポート対象外と[docs](https://learn.microsoft.com/ja-jp/javascript/api/requirement-sets/common/nested-app-auth-requirement-sets?view=common-js-preview)に書かれているのですが、色々試している限りは2024年11月時点ではちょっと違うみたい？

![](./image.png)

調べてみた感じはこんな結果でした。

- WindowsにてEdge、Chromeを利用した場合、NAAは期待通り動作した
- iPadにてSafari、Chromeを利用した場合、NAAは動作しない

NAAに対応しているかどうかをチェックする以下のコードを実行するとiPad上のOutlook on the webでもtrueが返ってきます。
`Office.context.requirements.isSetSupported("NestedAppAuth", "1.1")`

そしてこの状況でiPadでNAAができるだろうと思って処理を続行すると、acquireTokenSilentメソッドは失敗しacquireTokenPopupメソッドも動かず、謎な空のダイアログが残り続けるという状況に。。

ということで、現時点ではiPadのOutlook on the webではNAAは使えないようなので、以下のようなコードでiPadで動作しているかどうかをチェックして、NAAを使用するかどうかを決定するのが良さそう。

```
if (navigator.userAgent.includes("iPad")) {
// iPadで動作してます！
}
```

これってきっと、Android上のOutlook on the webも同様なんでしょうね。
端末がないので試せてないですが・・・
