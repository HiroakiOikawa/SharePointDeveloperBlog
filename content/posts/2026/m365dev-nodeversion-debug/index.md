---
title: "Azure Functions (Node.js) で Node バージョンを固定して VSCode でデバッグする方法"
date: 2026-03-22T10:00:00+09:00
draft: false
description: "複数のプロジェクトで Node のバージョンが異なる状況において、VSCode を使ってデバッグをする方法をまとめました。"
slug: "functions-nodeversion-debug"
tags:
  [
    "Node.js",
    "nvs",
    "VSCode",
    "チーム開発",
    "Azure Functions",
    "デバッグ"
  ]
categories: ["開発環境"]
showToc: true
tocopen: true
---
## はじめに

[前回の記事](https://sharepoint.orivers.jp/posts/m365dev-nodeversion/)では、SPFx / Office Web アドイン / Azure Functions を並行して開発する中で、Node.js のバージョン差異に影響を受けずに開発を進めるための環境構築について記載しました。

そこで、
**nvs + .nvmrc を使った Node.js バージョン管理**
を取り入れる方法をまとめました。

この記事では、その続きとして、

*   Azure Functions（Node.js）にフォーカスし
*   ローカル開発・デバッグ時に
*   Node.js のバージョンを確実に指定した状態でデバッグする

ために、必要な構成を整理します。

Copilot に聞きながら試行錯誤して最終的に出来上がった構成なので AI に聞くよりこれを読んだ方が早くゴールにたどり着けるはず！？

ということで、自分のメモとして書いてます。

## 採用した構成

試行錯誤の末に最終的に落ち着いた構成は以下の通りです。

*   **nvs（Node Version Switcher）**
*   **.nvmrc** によるプロジェクト単位の Node バージョン指定
*   **Azure Functions Core Tools**
*   **VS Code Attach デバッグ**

単純に F5 キーを押すだけでデバッグができる！という状態までは持って行けていないのですが、これで安定してデバッグができるようにはなります。

F5 キーだけでデバッグができるようにすることもチャレンジしたけどうまくいきませんでした。。

## .nvmrc による Node バージョン指定

前回の記事でも記載の通り、プロジェクトごとの Node バージョンの強制は `.nvmrc` を使います。

プロジェクトのルートフォルダに`.nvmrc`という拡張子のファイルを作り以下のようにバージョン番号のみ記載します。

```nvmrc
22.0.0
```

なお、チーム開発を楽にするために、`.nvmrc`ファイルは Git 管理対象に含めます。

## デバッグでやってはいけなかったこと

試行錯誤の中で、**やらない方がよい**と分かったことも整理しておきます。

*   NODE_OPTIONS=--inspect
*   nvs exec func host start

Copilot は上記を使うように指示してきましたが、実際に試したところ Azure Functions Core Tools の Worker / Inspector 管理と衝突しやすく、以下の問題が発生しました。

*   address already in use
*   Inspector が二重起動する

## 正解だった起動・デバッグ方法

### デバッグ開始コマンドを個別実行する

デバッグを始める前に、`start-debug.ps1`を実行し、Functions をデバッグできる状態でローカルで実行させます。

`start-debug.ps1`

```powershell
$ver = (Get-Content -Raw -Path ".nvmrc").Trim()

Write-Host "`nAzure Functions host started." -ForegroundColor Green
Write-Host "Press F5 to attach the debugger." -ForegroundColor Green

nvs use $ver
func host start --inspect=9229
```

### ポイント

*   先に `nvs use` で Node バージョンを切り替える
*   同じターミナルで `func host start`
*   Inspector の管理は Core Tools に任せる

## VSCode での対応（launch.json）

VSCode の `launch.json` を修正してデバッガがローカル実行している Functions のプロセスにアタッチできるようにします。

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Attach to Node Functions",
      "type": "node",
      "request": "attach",
      "address": "localhost",
      "port": 9229
    }
  ]
}
```
## デバッグの流れ

デバッグ時は、VSCode のターミナルにて以下のコマンドを実行します。

```powershell
.\start-debug.ps1
```

すると以下のようにローカル実行が始まります。

```powershell
Azure Functions host started.
Press F5 to attach the debugger.


Azure Functions Core Tools
Core Tools Version:       4.8.0+ec58eb7110992ea02aa19e9c060e45ac8882cc02 (64-bit)
Function Runtime Version: 4.1046.100.25610

[2026-03-22T03:35:14.333Z] Worker process started and initialized.

Functions:

        functionA: [POST] http://localhost:7071/api/xxxxxx

For detailed output, run func with --verbose flag.
```

上記が表示された後、F5 キーを押下することでデバッグを行うことができます。

## まとめ（前回記事と合わせて）

*   Node.js バージョン管理は **プロジェクト単位で明示**
*   `.nvmrc + nvs` は SPFx / Add-in / Functions で共通に使える
*   Azure Functions のデバッグは  
    **nvs use → func host start --inspect → VS Code Attach**
*   Inspector 周りは **Core Tools に任せる**

前回の記事と合わせて読んでいただくことで、プロジェクト単位で Node.js バージョンが異なる状況でも安定して使える開発環境を構築することができるようになるかと思います。

Office アドインでも開発のポイントが出てきたら別途まとめたいと思います。