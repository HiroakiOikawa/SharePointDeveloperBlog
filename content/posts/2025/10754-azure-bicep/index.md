---
title: "Azure環境を自動的に構築するBicepが超便利！"
description: "Azureの環境を自動的に構築するbicepの使い方を紹介します。bicepを活用することで同じ環境を繰り返し何度でも構築できるようになり、環境構築が劇的に楽になります！"
date: 2025-04-12T12:58:34+09:00
slug: "10754-azure-bicep"
categories: ["Azure"]
tags: ["Azure", "Bicep", "自動化"]
aliases: ["/article/10754/"]
draft: false
---
## はじめに

OutlookアドインやSharePoint Frameworkのパーツなどの開発をしていると、Azure Functionsやストレージを使うことが良くあります。
これまではその度に環境をゼロベースで構築していたのですが、そんな労力を削減してくれる便利な機能がAzureには備わっています。
それが、Bicepというものなのですが、これが非常に便利なので触りだけ紹介です。
公式情報はこちらにあるので、詳細知りたい方はどうぞ。
<https://learn.microsoft.com/ja-jp/azure/azure-resource-manager/bicep/overview?tabs=bicep>

## Bicepとは？

Bicepは、Azureリソースをデプロイするための宣言型構文を使用した専用言語です。
これにより、リソースの一貫したデプロイを可能にし、コードを再利用することで様々な環境を再現性を持って繰り返し素早く構築することができるようになります。

## 使い方

まずはBicepの本体となるファイルを作成します。
Bicepファイルの作成はVSCodeを使うと便利です。
例としてストレージアカウントを自動作成するBicepファイルを記載します。
このコードでは、dataStorageAccountというストレージアカウントを作って、そのストレージアカウントのBlobにConfigという名前のコンテナを作成します。
また、リージョンに関してはパラメータで受け取るようにしています。

```
// パラメータ
@description('リソースのロケーション')
param location string
// ストレージアカウント
resource dataStorage 'Microsoft.Storage/storageAccounts@2023-05-01' = {
name: 'dataStorageAccount'
location: location
sku: {
name: dataStorageSku
}
kind: 'StorageV2'
properties: {
dnsEndpointType: 'Standard'
publicNetworkAccess: 'Enabled'
supportsHttpsTrafficOnly: true
minimumTlsVersion: 'TLS1\_2'
}
}
// Blobの設定
resource dataStorageBlobServices 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
name: 'default'
parent: dataStorage
properties: {
containerDeleteRetentionPolicy: {
enabled: true
days: 7
}
deleteRetentionPolicy: {
allowPermanentDelete: false
enabled: true
days: 7
}
}
}
// Configコンテナの作成
resource dataStorageBlobServicesContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
parent: dataStorageBlobServices
name: 'config'
properties: {
immutableStorageWithVersioning: {
enabled: false
}
defaultEncryptionScope: '$account-encryption-key'
denyEncryptionScopeOverride: false
publicAccess: 'None'
}
}
```

上記の内容を拡張子「.bicep」のファイルとして保存することで、Bicepファイルが作成できます。
今回は「test.bicep」として保存します。

続いて上記Bicepのパラメータを指定して実行するための拡張子「.bicepparam」ファイルを作成します。
こちらもVSCodeで作成します。
ファイル名は「test.bicepparam」としておきます。

```
// 元となるbicepファイルを指定
using 'test.bicep'
// bicepで宣言されたパラメータに引き渡す値
param location = 'japaneast'
```

これで必要なファイルは作成できたので、最後に実行します。
ただ、実行すると早速環境構築が始まってしまうので、まずはこのファイルが既存環境にどのような影響を与えるのかと、そもそも構文エラーなどが発生しないかを確認するために、チェックするのをお勧めます。
やり方は以下の通りで、VSCodeのターミナルで実行します。

```
az login
az deployment group what-if --name TestDeploy --resource-group Test --parameters ./test.bicepparam
```

1行目はAzureへのログインをするためのコマンドです。
2行目がチェックコマンドで、what-ifというパラメータを付け、デプロイ先のリソースグループとbicepparamファイルを指定します。
これを実行すると、このbicepファイルを実行することで、新規作成されるリソース、変更されるリソース、削除されるリソース、影響を受けないリソースが表示されます。
その内容を確認して、bicepファイルが想定通りの動きになっているかを確認します。

上記が問題なければ、最後に以下のコマンドを実行して環境を構築します。

```
az deployment group create --name TestDeploy --resource-group Test --parameters ./test.bicepparam
```

what-ifとしていたところをcreateに変えただけですが、これで実際に環境が構築されます。

## まとめ

Bicepを使うことで普段Azure Portal上でマウスぽちぽちで作成していたリソースをコマンドで作成できるようになります。
最初はBicepファイルを作るのが大変ですが、やり方が分かってしまえばこれほど便利なものはありません。
自ら手を動かさずとも、決まった通りの環境を複製できるし、これを開発チームに配り開発メンバーそれぞれが自分専用の環境を作ったり、ということができてしまいます。
また、CI/CDの中にBicepを組み込むことで、常に最新の環境を自動デプロイするということも実現できます。

まさにクラウドインフラだからこそ手軽にできる技かなと。
これは使わない理由はないよねと思います。
