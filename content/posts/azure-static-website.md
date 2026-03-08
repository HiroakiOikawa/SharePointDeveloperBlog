---
title: "Azure Blob Storage で Hugo ブログを公開する完全ガイド"
date: 2026-03-08T10:00:00+09:00
draft: true
description: "Hugo でビルドした静的サイトを Azure Blob Storage の静的Webサイト機能を使って公開する手順を解説します。"
tags: ["Azure", "Hugo", "静的サイト", "Blob Storage"]
categories: ["クラウド"]
series: ["Azure入門"]
showToc: true
tocopen: true
---

## はじめに

Azure の **Blob Storage** には静的 Web サイトのホスティング機能があります。

{{< adsense >}}

## 手順

### 1. ストレージアカウントの作成

```bash
az group create --name rg-my-blog --location japaneast

az storage account create \
  --name mystorageaccount \
  --resource-group rg-my-blog \
  --sku Standard_LRS \
  --kind StorageV2
```

### 2. 静的 Web サイト機能を有効化

```bash
az storage blob service-properties update \
  --account-name mystorageaccount \
  --static-website \
  --index-document index.html \
  --404-document 404.html
```

### 3. Hugo ビルドとデプロイ

```bash
hugo --minify

az storage blob upload-batch \
  --account-name mystorageaccount \
  --source ./public \
  --destination '$web' \
  --overwrite
```

## まとめ

Azure Blob Storage の静的 Web サイト機能を使うことで、
サーバー管理不要・低コストでブログを公開できます。
