---
title: "SharePoint Framework v1.13 の変更点"
description: "2021年10月21日に SharePoint Framework v1.13 がリリースされました。この記事では v1.13 の変更点についてまとめたいと思います。"
date: 2021-10-28T23:25:38+09:00
slug: "10539-sharepoint-framework-v1-13"
categories: ["Office 365", "SharePoint", "SPFx", "開発とプログラミング"]
tags: ["M365Dev", "SharePoint", "SPFx"]
aliases: ["/article/10539/"]
draft: false
---
2021年10月21日に SharePoint Framework v1.13 がリリースされました。
この記事では v1.13 の変更点についてまとめたいと思います。
元ネタは以下のリリースノートになります。
[SharePoint Framework v1.13 のリリース ノート](https://docs.microsoft.com/ja-jp/sharepoint/dev/spfx/release-1.13?WT.mc_id=M365-MVP-4012897)
これまでのリリースノートでは各変更点を詳しく説明する資料があったのですが、今回はそういったものが無いのでリリースノートに書いてあること以上のことは現時点では書けません。
追々自分で検証して確認していきたいと思います。
なお、SharePoint Framework v1.13 に対応した Docker イメージは [Docker Hub](https://hub.docker.com/r/waldekm/spfx/) からダウンロード可能ですが、お勧めは[この記事](https://sharepoint.orivers.jp/article/10501)で紹介している Visual Studio Code Remote Container を使用した方法なので、[こちらから](https://github.com/waldekmastykarz/docker-spfx/blob/master/Dockerfile) Dockerfile をダウンロードして Remote Container で環境作っていただければと思います。

## ローカルワークベンチの削除

このリリースでローカルワークベンチがついに削除されました。
今後は、SharePoint Online のワークベンチを使ってデバッグをすることになります。
そもそも、ローカルワークベンチでは SharePoint API も Teams API もコンテキストが取れずに使用することができなかったので、それほど影響はないのかもしれません。
この変更とあわせて、オンプレ用の SharePoint Framework ソリューションも作成できなくなりました。
オンプレ用として SharePoint Framework を使用したい場合は、v1.12.1 以前を使用する必要があります。

## 各種更新

細かなところで、以下の更新が含まれます。

- Viva Connection の拡張機能開発への対応
- Microsoft Teams SDK を v1.10 にバージョンアップ
- React を v16.13.1 にバージョンアップ
- TypeScript を v3.9 にバージョンアップ
- 新しい画像レンダリング API のリリース

[AdSense-B]
