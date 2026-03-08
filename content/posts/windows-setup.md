---
title: "Hugo PaperMod ブログ 初回セットアップ（Windows）"
date: 2026-03-09T10:00:00+09:00
draft: true
description: ""
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

> **動作要件**: Windows 10 以降

---

## Step 1: Git のインストール

PowerShell（管理者）を開いて実行します。

```powershell
winget install Git.Git
```

インストール後、**PowerShell を再起動**して反映させます。

```powershell
git --version   # git version 2.x.x と表示されれば OK
```

> **⚠️ ここで認識されない場合は Step 2 完了後に PATH の手動登録が必要です（後述）**

---

## Step 2: Hugo extended版のインストール

PaperMod は Sass/SCSS 処理のため **extended 版**が必要です。

```powershell
winget install Hugo.Hugo.Extended
```

PowerShell を再起動してから確認します。

```powershell
hugo version
# hugo v0.x.x+extended windows/amd64 と表示されれば OK
# ↑ "extended" の文字が入っていること！
```

### ⚠️ hugo が認識されない場合：PATH を永続登録する

VSCode を再起動しても `hugo` が認識されない場合は以下を実行します。

```powershell
# winget のシムリンク先を確認
$hugoDir = Get-ChildItem "$env:LOCALAPPDATA\Microsoft\WinGet\Links" -Filter "hugo.exe" |
           Select-Object -First 1 -ExpandProperty DirectoryName

# ユーザー PATH に永続追加
$currentPath = [System.Environment]::GetEnvironmentVariable("PATH", "User")
if ($currentPath -notlike "*WinGet\Links*") {
    [System.Environment]::SetEnvironmentVariable("PATH", "$currentPath;$hugoDir", "User")
    Write-Output "✅ PATH に追加しました。VSCode を完全再起動してください。"
} else {
    Write-Output "✅ すでに PATH に含まれています"
}

# 現在のセッションにも即時反映
$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH","Machine") + ";" +
            [System.Environment]::GetEnvironmentVariable("PATH","User")
hugo version   # ← extended と表示されれば OK
```

---

## Step 3: Azure CLI のインストール

```powershell
winget install Microsoft.AzureCLI
```

```powershell
az --version   # azure-cli 2.x.x と表示されれば OK
```

---

## Step 4: プロジェクト作成 & テーマ取得

```powershell
# 任意の作業フォルダに移動（例: Documents）
cd $env:USERPROFILE\Documents

# Hugo プロジェクト作成
hugo new site my-tech-blog
cd my-tech-blog

# Git 初期化 & PaperMod を submodule として追加
git init
git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod themes/PaperMod
```

---

## Step 5: 設定ファイルの配置

プロジェクトルートの `hugo.toml` を削除し、
用意した `hugo.yaml` をプロジェクトルートに配置します。

```powershell
# デフォルトの hugo.toml を削除
Remove-Item hugo.toml

# あとは用意済みの各ファイルを所定の場所にコピーする
# （layouts/, content/, .github/, .vscode/ 等）
```

---

## Step 6: VSCode のインストール（未導入の場合）

```powershell
winget install Microsoft.VisualStudioCode
```

プロジェクトを VSCode で開きます。

```powershell
code .
```

VSCode が開いたら、推奨拡張機能のインストールを促すポップアップが
右下に表示されるので「インストール」をクリックします。
（`.vscode/extensions.json` の設定が自動で読み込まれます）

---

## Step 7: ローカルサーバー起動

```powershell
# 下書き含めてプレビュー
hugo server --buildDrafts

# ブラウザで http://localhost:1313/ を開く
Start-Process "http://localhost:1313/"
```

---

## Step 8: 新記事の作成

```powershell
hugo new posts/my-first-post.md
```

生成されたファイルが `content\posts\my-first-post.md` に作成されます。
VSCode で開いてスニペット `hfm` + Tab でFront Matterを展開できます。

---

## Step 9: ビルド & Azure へデプロイ

```powershell
# ビルド
hugo --minify --gc

# Azure ログイン
az login

# $web コンテナへアップロード
az storage blob delete-batch `
    --account-name <your-storage-account> `
    --source '$web' `
    --auth-mode login

az storage blob upload-batch `
    --account-name <your-storage-account> `
    --source .\public `
    --destination '$web' `
    --auth-mode login `
    --overwrite
```

> **ヒント**: PowerShell では行継続に `` ` ``（バッククォート）を使います。
> Bash の `\` とは異なる点に注意してください。

---

## Mac との主な違いまとめ

| 項目                    | Mac                 | Windows                                  |
| ----------------------- | ------------------- | ---------------------------------------- |
| パッケージマネージャー  | `brew`              | `winget`（Windows標準）                  |
| Hugo インストール       | `brew install hugo` | `winget install Hugo.Hugo.Extended`      |
| PowerShell の行継続     | `\`                 | `` ` ``（バッククォート）                |
| パス区切り              | `/`                 | `\`（PowerShellは `/` も可）             |
| RM コマンド             | `rm -rf`            | `rd /s /q` または `Remove-Item -Recurse` |
| 環境変数（ホーム）      | `$HOME`             | `$env:USERPROFILE`                       |
| VSCode でフォルダを開く | `code .`            | `code .`（同じ）                         |
