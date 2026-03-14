---
title: "SPFx、Office Web アドイン開発でありがちな Node.js のバージョンが環境ごとに異なる場合の開発環境の工夫（チーム開発前提）"
date: 2026-03-08T10:00:00+09:00
draft: false
description: "SPFx や Office Web アドイン、Azure Functions を並行開発する際の Node.js バージョン管理を nvs + .nvmrc で整理する方法をまとめます。"
slug: "m365dev-nodeversion"
tags:
  [
    "SPFx",
    "Node.js",
    "nvs",
    "VSCode",
    "チーム開発",
    "Office アドイン",
    "Azure Functions",
  ]
categories: ["開発環境"]
showToc: true
tocopen: true
---

## はじめに

SPFx や Office Web アドイン、Azure Functions を行ったり来たりする開発をしていると、Node.js のバージョン違いで思わぬところに引っかかることがあります。

この記事は**個人開発ではなくチーム開発**を前提に、Node.js のバージョンをプロジェクト単位で揃えやすくするために、最近落ち着いたやり方をまとめたものです。

## 以前は Remote Containers を推奨していました

以前は、Remote Containers（Dev Containers）をよく使っていました。

チーム開発だと、環境差異が出ると面倒なので「まず揃える」ための手段としては理にかなっていると思っていました。

## ただし、実際に使ってみると別の問題が見えてきました

一方で、実運用していく中で次のような点が気になり始めました。

- コンテナ起動が遅い
- ファイル I/O がもっさりする
- watch / hot reload の反応が悪い

「ちょっと直して確認する」を繰り返す作業では、これが積み重なって体感の遅さにつながります。

特に SPFx や Office Web アドインは gulp / webpack / ファイル監視など I/O に寄った処理が多いので、ここが遅いと開発スピードに直結しやすい印象でした。

## 方針転換のきっかけ

この点を整理していた際に、Copilot から以下のようなアドバイスをもらい、考え方を切り替えることにしました。

- Remote Containers は「環境再現性」を最優先したい場面では非常に有効
- 日常の開発ではスピード面で不利になることが多い
- 常用ではなく、用途を限定した方がよい

つまり、**Remote Containers は検証・再現用途**に絞り、**日常の実装はホスト OS 上で高速に行う**という使い分けです。

加えて、**Windows 11 の Dev Drive** の存在も方針転換の後押しになりました。I/O が多い開発が多いので、この恩恵を受けられるならホスト開発に寄せて速度を上げたい、という気持ちもありました。

## ホスト開発に戻すと、また別の問題が出てくる

ホスト OS 上で開発するようにすると、今度は Node.js のバージョン管理が表に出てきます。

### SPFx は「SPFx のバージョンごとに Node.js が変わる」

SPFx は、SPFx のバージョンに応じて対応する Node.js（LTS）が公式に整理されています。
例えば SPFx 1.22.0 は Node.js v22、1.20.0 は v18 といった形で互換表に明記されています。

**参考（公式）**
[SharePoint Framework プラットフォームおよびツールチェーンの互換性リファレンス](https://learn.microsoft.com/ja-jp/sharepoint/dev/spfx/compatibility)

SPFx のアップデートも比較的早いので、**Node.js を 1 つに固定して全プロジェクトを回すのは現実的ではないと思います。**

### Office Web アドインは「最新 LTS」前提になりやすい

Office Web アドイン（Office Add-ins）は、公式ドキュメント上は Node.js について「最新 LTS」を前提にセットアップする案内になっています。

SPFx のように「このバージョンだけ」という縛りはなく、相対的に柔軟です。

### Azure Functions は（現在）v4 が主流で、Node 22 以降で開発する必要がある

Azure Functions（JavaScript / TypeScript）は、現在主流の **Node.js programming model v4** では、Azure 側でサポートされている Node.js バージョンで開発する必要があります。

ローカル開発環境も、この制約に合わせて揃える必要があります。

## Node のバージョンを固定させるには

ここで必要なのは、Node.js のバージョンに「気を使う」運用にしないことです。

チーム開発では、誰かの環境のズレが無用な調査を生み出しチーム全体の生産性が低下してしまいます。

そこで、**プロジェクト単位で Node.js のバージョンを明示し、できるだけ自動で切り替わる状態**を作り込みます。そのために今回使ったのが **nvs（Node Version Switcher）** です。

## nvs のインストール（MSI）

nvs は GitHub の Releases から **Windows Installer（MSI）** をダウンロードしてインストールします。

公式のセットアップ手順でも、Windows は MSI を利用する形で案内されています。

### インストール時の注意点

- インストール先のパスに空白を含めない
- インストールフォルダに書き込み権限があること

## 使用する Node.js を登録

インストール後、必要なバージョンだけ入れます。

```powershell
nvs add 18.19.0
nvs add 22.0.0
```

nvs とだけ入力して実行するとカーソルでバージョンを選択できるので、バージョンを選んで指定したい方はそちらの方が便利です。

## 自動切り替えを有効化する

次に自動切り替えを有効化します（これは 1 回だけで OK）。

```powershell
nvs auto on
```

## VS Code ではこれだけではうまくいかず・・・

VS Code の統合ターミナルでは、`nvs auto on` だけだと期待どおりに切り替わらないケースがありました。

そこで、**ターミナル起動時に明示的に `nvs use` を実行**する設定を加えました。

### `.vscode/settings.json`

```json
{
  "terminal.integrated.cwd": "${workspaceFolder}",
  "terminal.integrated.defaultProfile.windows": "PowerShell",
  "terminal.integrated.profiles.windows": {
    "PowerShell": {
      "source": "PowerShell",
      "args": [
        "-NoExit",
        "-NoProfile",
        "-Command",
        "$ErrorActionPreference='SilentlyContinue'; if (Test-Path .nvmrc) { $v=(Get-Content -Raw .nvmrc).Trim(); if($v){ nvs use $v | Out-Null } }"
      ]
    }
  }
}
```

> **⚠️ 注意:** この設定を入れたあと、既存ターミナルには反映されません。ターミナルを一度 Kill して作りなおす必要があります。

## プロジェクトごとに `.nvmrc` を置く

各プロジェクトのルートに `.nvmrc` を置きます。`.nvmrc` を Git に入れれば、チームメンバー全員が自動的に同じ Node バージョンを利用できるようになります。

`.nvmrc` の中には使用したい Node のバージョン番号を記載します。

```nvmrc
22.0.0
```

プロジェクトごとの目安は以下の通りです。

| プロジェクト        | Node.js バージョンの基準                       |
| ------------------- | ---------------------------------------------- |
| SPFx                | その SPFx バージョンに対応する Node.js         |
| Office Web アドイン | チームで動作確認した LTS                       |
| Azure Functions     | v4 前提で Azure 側のサポートに合わせた Node.js |

## まとめ

Office Web アドインや Azure Functions は、SPFx ほど Node のバージョンの縛りがきつくないのですが、並行開発していると、結局 Node.js の切り替え忘れでハマる可能性があります。

Office Web アドインや Functions も含めて、プロジェクトごとに `.nvmrc` を置いて前提を明示しておくだけで、Node が原因で時間を無駄に使うことを減らすことができるかと思います。

チーム開発では特に問題になりやすい箇所なので、nvs + `.nvmrc` + VS Code 設定を活用することをお勧めします。
