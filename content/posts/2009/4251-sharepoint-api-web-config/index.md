---
title: "SharePoint API で web.config を変更する"
description: "SharePoint API には、web.configを変更するためのクラスが用意されています。 このクラスを使うことで、たとえばFeatureのインストール時に自動的にweb.configを変更するということができるようになります。 w…"
date: 2009-08-28T10:01:39+09:00
slug: "4251-sharepoint-api-web-config"
categories: ["SharePoint 2007", "開発とプログラミング"]
aliases: ["/article/4251/"]
draft: false
---
SharePoint API には、web.configを変更するためのクラスが用意されています。
このクラスを使うことで、たとえばFeatureのインストール時に自動的にweb.configを変更するということができるようになります。
web.configの変更には、[SPWebConfigModification](http://msdn.microsoft.com/ja-jp/library/microsoft.sharepoint.administration.spwebconfigmodification.aspx)クラスと[SPWebService](http://msdn.microsoft.com/ja-jp/library/microsoft.sharepoint.administration.spwebservice.aspx)クラスを利用します。
例として、web.config内のappSettingsに値を追加する処理を書いてみます。
**１．変更内容をSPWebConfigModificationクラスにセットする。**SPWebConfigModificationクラスは、web.configに加える変更情報を保持するクラスです。
web.configを変更したい場合には、このクラスに変更内容をセットすることになります。

```
1: SPWebConfigModification appSetting = new SPWebConfigModification();
```
```
2: appSetting.Path = "configuration/appSettings";
```
```
3: appSetting.Name = "add[@key='NewKey']";
```
```
4: appSetting.Owner = "orivers";
```
```
5: appSetting.Sequence = 0;
```
```
6: appSetting.Type = SPWebConfigModification.SPWebConfigModificationType.EnsureChildNode;
```
```
7: appSetting.Value = "<add key='NewKey' value='NewValue'/>";
```

 
各プロパティの詳細はヘルプを見ていただくとして、ここでは簡単に説明します。
Pathプロパティに変更対象となるノードを指定し、Valueプロパティに変更内容を指定します。
Nameプロパティは、この変更を一意に識別するための値です。
Ownerプロパティも、Nameプロパティと合わせて、変更を一意に識別するために使用します。
Typeプロパティは、変更内容に合わせたタイプを指定します。
**２．変更を実行する。**SPWebConfigModificationクラスの作成が完了したら、web.configのアップデートをしたいWebアプリケーションで変更を実行します。

```
1: SPWebService service = SPWebService.ContentService;
```
```
2: service.WebConfigModifications.Add(appSetting);
```
```
3: service.Update();
```
```
4: service.ApplyWebConfigModifications();
```

SPWebService.ContentServiceプロパティで、変更対象のWebアプリケーションを取得しています。
取得したWebアプリケーションのWebConfigModificationsコレクションに、手順１で作成したSPWebConfigModificationクラスのインスタンスを指定し、Updateメソッドを実行します。
最後にApplyWebConfigModificationsメソッドを実行して、ファーム全体に変更を反映します。
これで変更完了です。
