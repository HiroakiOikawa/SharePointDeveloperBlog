---
title: "SharePoint Framework での SharePoint REST API 呼び出し (async/await 編)"
description: "別記事にて、 SharePoint Framework の SPHttpClient による SharePoint REST API 呼び出しで Promise を使った場合のパターンについて記事を書きましたが、今度は Promise を使…"
date: 2020-10-11T23:31:53+09:00
slug: "10393-sharepoint-framework-sharepoint-rest-api-async-await"
categories: ["Office 365", "SharePoint", "SPFx", "コードスニペット", "開発とプログラミング"]
tags: ["async/await", "M365Dev", "REST", "SharePoint", "SPFx", "spHttpClient", "非同期"]
aliases: ["/article/10393/"]
draft: false
---
# はじめに

[別記事](https://sharepoint.orivers.jp/article/10389)にて、 SharePoint Framework の SPHttpClient による SharePoint REST API 呼び出しで Promise を使った場合のパターンについて記事を書きましたが、今度は Promise を使わず、TypeScript の async/await を使ったパターンについて書きたいと思います。

# async/await を使った SharePoint REST API 呼び出しのサンプル

## GET 処理

概ね以下のようなコードになるかと思います。
ちなみにこの例は、指定のリストの指定のアイテム ID のアイテムについて列を指定してデータを取得するものとなります。
```
async proc() {
try {
const url: string = `${this.context.pageContext.web.absoluteUrl}/\_api/web/lists/getbyid('${this.context.pageContext.list.id.toString()}')/items(${itemId})?$select=${selectFields}`;
const response = await this.context.spHttpClient.get(url, SPHttpClient.configurations.v1);
const json = await response.json();
if (response.ok) {
// 成功時の処理
・・・
} else {
// 失敗時の処理
・・・
}
} catch (e) {
// 失敗時の処理
・・・
}
}
```
async/await を使うことで、Promise を使う時のように、非同期処理一つ一つに対して then/catch を使う必要がなくなり、try/catch で非同期処理全体を括るだけでよくなります。
順次処理を記述するのと同じ感じで書けるのでとても分かりやすいですね。
ただ、Promise を使う場合と同様で spHttpClient.get メソッドが成功しても response.ok が false になるケースがあるため、response.ok をチェックして成功失敗を区別する必要はあります。

## POST 処理

GET 処理との違いは、POST するデータを [spHttpClient.post](https://docs.microsoft.com/en-us/javascript/api/sp-http/sphttpclient?WT.mc_id=M365-MVP-4012897&view=sp-typescript-latest#post-url--configuration--options-) メソッドの第 3 引数に渡す必要があるところだけで、他は GET と同じです。
```
async proc() {
try {
const dataJSON: any = '{"Title":"test","Body":"test"}';
const options: ISPHttpClientOptions= {
body: JSON.stringify(dataJSON)
};
const url: string = `${this.context.pageContext.web.absoluteUrl}/\_api/web/lists/getbyid('${this.context.pageContext.list.id.toString()}')/items`;
const response = await this.context.spHttpClient.post(url, SPHttpClient.configurations.v1,options);
const json = await response.json();
if (response.ok) {
// 成功時の処理
・・・
} else {
// 失敗時の処理
・・・
}
} catch (e) {
// 失敗時の処理
・・・
}
}
```

# REST API Call 処理の共通化

spHttpClient.get メソッドも spHttpClient.post メソッドも、メソッドを呼び出した後の JSON のチェック処理は共通的に行う必要があります。
また、SharePoint REST API の POST 処理において、HTTP レスポンスのステータスが 204 を返送することがあり、これに対する対処も共通的に行う必要があります。
これらの処理の共通化を行うために、以下のように callRestApi というファンクションを作ってみました。
なお、asyn/await を使用する場合でも、非同期処理に対応するファンクションは Promise を返却するように実装する必要があります。
```
private callRestApi(restApi: Promise<SPHttpClientResponse>): Promise<any> {
return new Promise(async (resolve: (json: any) => void, reject: (reson?: any) => void) => {
try {
let response = await restApi;
if (response.status === 204) {
resolve(null);
} else {
let json = await response.json();
if (response.ok) {
resolve(json);
} else {
Log.error(LOG\_SOURCE, json.error);
reject(json.error);
}
}
} catch (e) {
Log.error(LOG\_SOURCE, e);
reject(e);
}
});
}
```

## callRestApi ファンクションを利用した GET 処理

callRestApi ファンクションを使うと GET 処理のコードが 6 行削減できます。
```
async proc() {
try {
const url: string = `${this.context.pageContext.web.absoluteUrl}/\_api/web/lists/getbyid('${this.context.pageContext.list.id.toString()}')/items(${itemId})?$select=${selectFields}`;
let json = this.callRestApi(this.context.spHttpClient.get(url, SPHttpClient.configurations.v1));
// 正常時の処理
・・・
} catch(e) {
// 異常時の処理
・・・
}
}
```

## callRestApi ファンクションを利用した POST 処理

POST 処理も GET 処理と同様に 6 行コードを削減できます。
```
async proc() {
try {
const dataJSON: any = '{"Title":"test","Body":"test"}';
const options: ISPHttpClientOptions= {
body: JSON.stringify(dataJSON)
};
const url: string = `${this.context.pageContext.web.absoluteUrl}/\_api/web/lists/getbyid('${this.context.pageContext.list.id.toString()}')/items`;
let json = this.callRestApi(this.context.spHttpClient.post(url, SPHttpClient.configurations.v1, options));
// 正常時の処理
・・・
} catch (error) {
// 異常時の処理
・・・
}
}
```

# まとめ

async/await を使うのは初めてだったので試行錯誤しましたが、Promise を使うよりもより簡潔に分かりやすいコードにすることができました。
これからは async/await で書いていきたいと思います。
[AdSense-B]
