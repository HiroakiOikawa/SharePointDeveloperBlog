---
title: "言語に応じたサイトにリダイレクトする方法"
description: "SharePoint は多言語対応の仕組みとして、バリエーションという機能を持っており、言語ごとにサイトを作ることで、ブラウザの言語設定に応じたサイトへ自動的にリダイレクトする機能があります。 バリエーションを計画する（オンプレ） http…"
date: 2012-10-30T21:55:54+09:00
slug: "4961-post"
categories: ["Office 365", "SharePoint 2007", "SharePoint 2010", "SharePoint 2013", "開発とプログラミング"]
aliases: ["/article/4961/"]
draft: false
---
SharePoint は多言語対応の仕組みとして、バリエーションという機能を持っており、言語ごとにサイトを作ることで、ブラウザの言語設定に応じたサイトへ自動的にリダイレクトする機能があります。
バリエーションを計画する（オンプレ）
[http://technet.microsoft.com/ja-jp/library/cc262404.aspx](http://technet.microsoft.com/ja-jp/library/cc262404.aspx "http://technet.microsoft.com/ja-jp/library/cc262404.aspx")
多言語機能の概要（Office 365）
[http://office.microsoft.com/ja-jp/sharepoint-online-enterprise-help/HA101867790.aspx?CTT=5&origin=HA102034913](http://office.microsoft.com/ja-jp/sharepoint-online-enterprise-help/HA101867790.aspx?CTT=5&origin=HA102034913 "http://office.microsoft.com/ja-jp/sharepoint-online-enterprise-help/HA101867790.aspx?CTT=5&origin=HA102034913")
バリエーション機能を使うことで言語に応じたリダイレクトはできるのですが、バリエーション機能を使うためには発行機能を有効にする必要があったり、各国語サイトへのコンテンツ配信の仕組みを検討したりと、リダイレクトさせるだけでも、色々考えることがあります。
単純に言語に応じて、適切なサイトにリダイレクトさせたいというニーズを満たすだけであれば、バリエーションを使わずに JavaScript で済ませてしまうこともできます。
以下が、そのやり方になります。
**JavaScriptでブラウザの言語を取得してリダイレクトする方法**
JavaScript だけで言語に応じたリダイレクトをさせたい場合は、以下のコードを js ファイルとして保存し、リダイレクト元のサイトのドキュメントライブラリにアップロードし、リダイレクト元サイトのページにコンテンツエディタ Web パーツを配置して js ファイルを読み込むようにしてください。
```
<script type="text/javascript">
// ブラウザ言語の取得
function browserLanguage() {
try {
return (navigator.browserLanguage || navigator.language || navigator.userLanguage).substr(0,2)
}
catch(e) {
return undefined;
}
}
// ブラウザの言語が日本語の場合、日本語サイトへ、それ以外の場合英語サイトへリダイレクト
if (browserLanguage().indexOf("ja") != -1) {
location.replace("https://hoge.sharepoint.com/sites/ja");
}
else {
location.replace("https://hoge.sharepoint.com/sites/en");
}
</script>
```
 
こうすることで、上記設定をしたページを開くだけで、ブラウザの言語に応じたサイトへリダイレクトされるようになります。
ちなみに、上記サンプルでは、ブラウザの言語が日本語の場合は日本語サイトへ、それ以外の場合は英語サイトへリダイレクトしています。
これであれば、バリエーション機能を使うよりも手軽にリダイレクトを実現することができます。
**注意！**
ただし注意点があります。
上記設定をしたページを開くだけでリダイレクトされてしまうため、ページの設定変更を行いたい時にもリダイレクトされてしまうので、少々不便です。
この問題を回避するには、ページの編集をする前にまず js ファイルを置いたドキュメントライブラリにアクセスして、js ファイルをリネーム等して コンテンツエディタ Web パーツ から呼び出されないようにする必要があります。
また、以下のサイトにあるようにこの JavaScript で取れる言語情報はブラウザによって異なり、ブラウザの言語設定とは一致しない場合があります。
[http://blog.masuidrive.jp/index.php/2008/09/19/how-to-detect-your-browser-language-from-javascript/](http://blog.masuidrive.jp/index.php/2008/09/19/how-to-detect-your-browser-language-from-javascript/ "http://blog.masuidrive.jp/index.php/2008/09/19/how-to-detect-your-browser-language-from-javascript/")
私が把握している限りでは、IE9で言語情報を取ると、ブラウザの言語設定で既定にしている言語が取れるのではなく、ブラウザそのものの言語、日本語版ブラウザであれば日本語、英語版ブラウザであれば英語が取れます。
これでいい場合もありますし、場合によってはブラウザの言語設定が取れないと困ることもあると思います。
この辺りは利用しているブラウザや環境ごとにご確認いただき、今回の仕組みで要件を満たせるかどうか、それぞれ判断いただく必要があります。
**もっと厳密にやる場合は・・・**
厳密にブラウザの言語設定に従って処理をしたいという場合には、サーバー側でHTTPリクエストヘッダを取得して処理をする必要があります。
試したことはないですが、例えばOffice365でも対応しようと思ったらサンドボックスソリューションを作って対応するとか、でしょうか。
あるいは、以下のサイトで紹介しているような、サーバーに一度リクエストを投げてその結果で言語を判別するという方法もあります。
[http://www1.kokusaika.jp/advisory/org/ja/js\_point.html](http://www1.kokusaika.jp/advisory/org/ja/js_point.html "http://www1.kokusaika.jp/advisory/org/ja/js_point.html")
いずれにしろ、厳密にやろうとすると非常に手間がかかります。
であれば、バリエーション機能を使ったほうがよいのかもしれないですね。
