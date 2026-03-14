---
title: "Microsoft 365 Virtual Marathon で初めてのオンラインイベント"
description: "2020年5月28日～29日に、世界規模で開催された Microsoft 365 Virtual Marathon というオンラインイベントにスピーカーとして参加させていただきました。その際の資料へのリンクや裏話を書いてみました。"
date: 2020-06-02T08:40:42+09:00
slug: "10271-microsoft-365-virtual-marathon"
categories: ["Office 365", "SharePoint", "勉強会・イベントなど"]
tags: ["M365VM", "Microsoft365dev", "Office365Dev", "SharePoint", "SPFx"]
aliases: ["/article/10271/"]
draft: false
---
# ご報告

2020年5月28日～29日に、世界規模で開催された Microsoft 365 Virtual Marathon というオンラインイベントにスピーカーとして参加させていただきました。
私はこれが初めてのオンラインイベントでの登壇で、リハーサルの時から機材大丈夫かなとか、おでこテカってないかなとか、背面大丈夫かなとか、色々考えて無駄に緊張してしまいましたｗ
これから YouTube で動画が公開される予定ですが現時点では自分の喋りっぷりは確認できておらず、これまた大丈夫かなと不安な点はあるのですが、ひとまずいつも通りの感じでできたかなと思っています。
ちなみに今回私のセッションをご視聴いただいた方の人数は180名弱くらいだったようです。
ご視聴いただいた多くの方々、本イベントの主催者やスタッフの方々、この度はとても良い機会をご提供いただき誠にありがとうございました。
またオンラインイベントやっていきたいですね。

# オンラインイベントの醍醐味

通常コミュニティイベントというと、休日にどこかの場所に集まってみんなで和気あいあいと楽しく勉強をするという感じで、それはそれでとても楽しいのですが、休日に家を空けるというのはなかなか大変なことで、これまであまりコミュニティイベントに参加できていませんでした。
でも、今回オンラインイベントを経験してみて、これはこれでオフラインのコミュニティイベントと同様にやりがいがあるし、何より参加いただける方が桁違いに多い！
だから、今までアプローチできなかった方々にも視聴いただくことができるようになったし、それによって生まれた新たなコミュニケーションもありました。
オンラインならではのこの経験はなかなか興味深いもので、これからのイベントの在り方を見直す良い機会なのかなと思いました。
さて、今回のイベントの詳細につきましては、日本チームのリーダーである平野愛さんが既にまとめ記事を投稿されているので、詳細はそちらをご覧ください。
[Microsoft 365 Virtual Marathon 無事に終了しました](https://shanqiai.weblogs.jp/sharepoint_technical_note/2020/06/microsoft-365-virtual-marathon-have-been-completed-well.html?fbclid=IwAR21qfx9frOdco-_NMFj5OOWDZ1Amcp3VwxOR9nRccNL1Pgdd8uFdlZ8bys)

# 裏話

ということで、大事なことはすべて愛さんのブログに書かれておりますので、ここでは私のセッションの裏話を少しだけ。
私は今回「SharePoint Framework によるモダンサイトのカスタマイズ」というタイトルで、SharePoint 開発の変遷と SharePoint Framework でどんなことができるのかということをお話させていただきました。
その時のスライドがこちらです。
 

**[SharePoint Framework によるモダンサイトのカスタマイズ](//www.slideshare.net/HiroakiOikawa/sharepoint-framework-234664612 "SharePoint Framework によるモダンサイトのカスタマイズ")**  from **[Hiroaki Oikawa](https://www.slideshare.net/HiroakiOikawa)**

YouTube でビデオも公開されました。
実はこの内容の一部は、私が時々登壇させていただいている [Japan SharePoint Group](http://jpsps.com/) というコミュニティのオフラインイベントで 2019年9月に登壇させていただいた時の内容を、もう少し開発者ではない方にも分かりやすくなるように内容を改変して、今のバージョンの SharePoint Framework に合わせてアップデートしたものになります。
その時のスライドがこちら。
 

**[SharePoint 開発でできること 2019年9月版](//www.slideshare.net/HiroakiOikawa/sharepoint-20199 "SharePoint 開発でできること 2019年9月版")**  from **[Hiroaki Oikawa](https://www.slideshare.net/HiroakiOikawa)**

ということで、実はあまりスライド作成には時間がかかっていませんw

また、私のセッションでは必ず自作の何かをデモさせていただくのですが、今回は以下の４つをデモさせていただきました。

- アプリケーションカスタマイザー（モダンページにヘッダー、フッターを追加する）
- フィールドカスタマイザー（ビューに表示する列にアイテムの添付ファイルへのリンクを表示し、リンクをクリックすると添付ファイルが開くようにする）
- コマンドセット（ビューのメニューと右クリックメニューにアイテムコピーのボタンを追加して任意のアイテムをコピーできるようにする）
- Web パーツ（Teamsの任意のチーム及びチャネルの投稿をサマリー表示する）

これらについては、以前私のブログや Microsoft 本社が主催で開催した Microsoft 365 Developer Bootcamp というイベントで紹介させていただいたものもあり、今回新規作成したのは Web パーツ以外の3つでした。
ちなみに、Developer Bootcamp の記事はこちらなので、良かったらご覧ください。

- [SharePoint Framework Extension (拡張機能) 基礎講座](https://sharepoint.orivers.jp/article/9898)
- [Teams タブ開発基礎講座](https://sharepoint.orivers.jp/article/9991)

そして本当はもう一つデモをやりたかったのですが、できなかったものがあります。
それは、SharePoint アドインの超簡単なデモだったのですが、SharePoint アドインは SharePoint Online でも使える強力な開発手法で、ASP.NET MVC で開発するため開発者の確保がしやすく、大規模開発も可能なものなので、エンタープライズ向けシステムには向いているかなと個人的には思っています。
オンプレで SharePoint アドインを動かす環境を作ろうと思うとなかなか大変なのですが、SharePoint Online ならかなり手軽に環境構築もできてしまいます。
こちらについても既に記事にしてあるので、参考までにリンクを貼っておきます。
良かったらこちらもご覧ください。

- [SharePoint Online で SharePoint アドイン（プロバイダーホスト型）を使用する](https://sharepoint.orivers.jp/article/10200)
- [SharePoint アドインのクライアント Web パーツをモダンページに配置してみた](https://sharepoint.orivers.jp/article/10236)

# 最後に

ダラダラと書いてしまいましたが、こんな感じで昔から「SharePoint の開発」という点にフォーカスして活動をしておりますので、今回のイベントを通じてご興味持っていただいた開発好きの方々は、これを機に SharePoint の世界にどっぷりはまっていただけたら嬉しいなと思います。
それでは今後ともよろしくお願いいたします。
[AdSense-B]
