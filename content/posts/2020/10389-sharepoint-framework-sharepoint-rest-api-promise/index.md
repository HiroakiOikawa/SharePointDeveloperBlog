---
title: "SharePoint Framework での SharePoint REST API 呼び出し (Promise 編)"
description: "SharePoint Framework にて SharePoint REST API を呼び出す方法について、Promise チェーンを書く際にあまりにも煩雑に感じた部分があったので、その点を解消するための自分なりのやり方をメモしました。"
date: 2020-09-27T00:22:06+09:00
slug: "10389-sharepoint-framework-sharepoint-rest-api-promise"
categories: ["Office 365", "SharePoint", "SPFx", "コードスニペット", "開発とプログラミング"]
tags: ["M365Dev", "REST", "SharePoint", "SPFx", "spHttpClient"]
aliases: ["/article/10389/"]
draft: false
---
# はじめに

SharePoint Framework にて SharePoint REST API を呼び出す方法について、Promise チェーンを書く際にあまりにも煩雑に感じた部分があったので、その点を解消するための自分なりのやり方をメモしました。

# Promise を使った SharePoint REST API 呼び出しのサンプル

## GET 処理

概ね以下のようなコードになるかと思います。
ちなみにこの例は、指定のリストの指定のアイテム ID のアイテムについて列を指定してデータを取得するものとなります。
```
const url: string = `${this.context.pageContext.web.absoluteUrl}/\_api/web/lists/getbyid('${this.context.pageContext.list.id.toString()}')/items(${itemId})?$select=${selectFields}`;
this.context.spHttpClient.get(url, SPHttpClient.configurations.v1)
.then((response: SPHttpClientResponse) => {
response.json().then((json: any) => {
if (response.ok) {
// 成功時の処理
} else {
// 失敗時の処理
}
}).catch((error: any) => {
// 失敗時の処理
});
}).catch((error: any) => {
// 失敗時の処理
});
```
[spHttpClient.get](https://docs.microsoft.com/en-us/javascript/api/sp-http/sphttpclient?WT.mc_id=M365-MVP-4012897&view=sp-typescript-latest#get-url--configuration--options-) メソッドの戻り値である response は REST の URL が違っている場合や呼び出しが失敗した場合については catch に処理が流れますが、SharePoint 内で問題が起きて REST が正しく動作しないような時は、処理は then に流れて、response.ok プロパティが false になります。
そのため、上記コードでは then の中で response.ok プロパティをチェックし false だった場合の処理（失敗時の処理）を入れています。
こうやって見ると、get をするだけでも、結構煩雑なことが分かります。

## POST 処理

GET 処理との違いは、POST するデータを [spHttpClient.post](https://docs.microsoft.com/en-us/javascript/api/sp-http/sphttpclient?WT.mc_id=M365-MVP-4012897&view=sp-typescript-latest#post-url--configuration--options-) メソッドの第 3 引数に渡す必要があるところだけで、他は GET と同じです。
```
const dataJSON: any = '{"Title":"test","Body":"test"}';
const options: ISPHttpClientOptions= {
body: JSON.stringify(dataJSON)
};
const url: string = `${this.context.pageContext.web.absoluteUrl}/\_api/web/lists/getbyid('${this.context.pageContext.list.id.toString()}')/items`;
this.context.spHttpClient.post(url, SPHttpClient.configurations.v1,options)
.then((response: SPHttpClientResponse) => {
response.json().then((json: any) => {
if (response.ok) {
// 成功時の処理
} else {
// 失敗時の処理
}
}).catch((error: any) => {
// 失敗時の処理
});
}).catch((error: any) => {
// 失敗時の処理
});
```

# 戻り値及び Promise の処理の共通化

spHttpClient.get メソッドも spHttpClient.post メソッドも、メソッドを呼び出した後の戻り値の処理と Promise の処理が煩雑です。
この煩雑さを低減したいと考え、以下のように callRestApi というファンクションを作って処理を共通化してみました。
```
private callRestApi(restApi: Promise<SPHttpClientResponse>): Promise<any> {
return new Promise((resolve: (value: any) => void, reject: (reson?: any) => void) => {
restApi.then((response: SPHttpClientResponse) => {
response.json().then((json: any) => {
if (response.ok) {
resolve(json);
} else {
Log.error(LOG\_SOURCE, json.error);
reject(json.error);
}
}).catch((error: any) => {
Log.error(LOG\_SOURCE, error);
reject(error);
});
}).catch((error: any) => {
Log.error(LOG\_SOURCE, error);
reject(error);
});
});
}
```

## callRestApi ファンクションを利用した GET 処理

callRestApi ファンクションを使うと GET 処理のコードが 9 行削減できます。
```
const url: string = `${this.context.pageContext.web.absoluteUrl}/\_api/web/lists/getbyid('${this.context.pageContext.list.id.toString()}')/items(${itemId})?$select=${selectFields}`;
this.callRestApi(this.context.spHttpClient.get(url, SPHttpClient.configurations.v1)).then((json: any) => {
// 正常時の処理
}).catch((error: any) => {
// 異常時の処理
});
```

## callRestApi ファンクションを利用した POST 処理

POST 処理も GET 処理と同様に 9 行コードを削減できます。
```
const dataJSON: any = '{"Title":"test","Body":"test"}';
const options: ISPHttpClientOptions= {
body: JSON.stringify(dataJSON)
};
const url: string = `${this.context.pageContext.web.absoluteUrl}/\_api/web/lists/getbyid('${this.context.pageContext.list.id.toString()}')/items`;
this.callRestApi(this.context.spHttpClient.post(url, SPHttpClient.configurations.v1, options)).then((json: any) => {
// 正常時の処理
}).catch((error: any) => {
// 異常時の処理
});
```

# まとめ

煩雑な処理を共通化することで、9 行のコードを削減することができました。
1 回の REST API コールであれば大差ありませんが、Promise チェーンを組んで複数の REST API コールをする際にはこの削減効果は大きくなります。
もっと短縮する方法もありそうですが、現在私が書いている書き方を紹介させていただきました。
[AdSense-B]
