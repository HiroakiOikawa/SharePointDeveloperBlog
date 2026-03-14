---
title: "Office 365 のプロファイル画像を変更する PowerShell スクリプト"
description: "Office 365 のプロファイル画像を変更するための PowerShell スクリプトのサンプルです。"
date: 2020-05-09T18:38:31+09:00
slug: "10254-office-365-powershell"
categories: ["Office 365", "開発とプログラミング"]
tags: ["Exchange", "Office365", "PowerShell", "SharePoint", "プロファイル画像"]
aliases: ["/article/10254/"]
draft: false
---
# はじめに

Office 365 のプロファイル画像を一括で変更するための PowerShell スクリプトを知りたいというお話をいただくことが多いので、ネットで検索してみたところ、確かにあまり情報がないようす。
ということで、検索にヒットしてくれるようになるかどうかは置いておいて、備忘録兼ねてスクリプトを残しておきたいと思います。

# 任意の画像をプロファイル画像として登録する

プロファイル画像の登録には「Set-UserPhoto」コマンドレットを使用します。
```
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking
# 以下の行で1名分の写真を登録します。 "herakles@orivers.jp"の部分には対象アカウントのメールアドレス、"D:\Users\Oikawa\Desktop\photo.jpg"の部分には画像ファイルのパスを指定してください。
# 複数人同時に登録をする場合は以下の行をコピーして、8行目以降に必要な分だけ貼り付けてください。
Set-UserPhoto -Identity "herakles@orivers.jp" -PictureData ([System.IO.File]::ReadAllBytes("D:\Users\Oikawa\Desktop\photo.jpg")) -Confirm:$false
Remove-PSSession $Session
Echo "完了"
```

# 登録したプロファイル画像をリセットする

一度登録したプロファイル画像をリセットして初期状態に戻すには「Remove-UserPhoto」コマンドレットを使用します。
```
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking
# 以下の行で1名分の写真を削除します。 "herakles@orivers.jp"の部分には対象アカウントのメールアドレスを指定してください。
# 複数人同時に削除をする場合は以下の行をコピーして、8行目以降に必要な分だけ貼り付けてください。
Remove-UserPhoto -Identity "herakles@orivers.jp" -Confirm:$false
Remove-PSSession $Session
Echo "完了"
```

# 参考

今回使用した二つのコマンドレットの詳細な説明は公式情報をご確認ください。

- [Set-UserPhoto](https://docs.microsoft.com/en-us/powershell/module/exchange/mailboxes/set-userphoto?view=exchange-ps&WT.mc_id=M365-MVP-4012897)
- [Remove-UserPhoto](https://docs.microsoft.com/en-us/powershell/module/exchange/mailboxes/remove-userphoto?view=exchange-ps&WT.mc_id=M365-MVP-4012897)

なお、今回のスクリプトでは Exchange Online への接続を基本認証を使って行っていますが、基本認証は期限付きのサポートとなるため将来的には多要素認証を使った接続に変える必要があります。
そちらについては、また試した際にアップデートするようにしますが、情報はこちらに掲載されています。
[多要素認証を使用して Exchange Online  PowerShell に接続する](https://docs.microsoft.com/ja-jp/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/mfa-connect-to-exchange-online-powershell?view=exchange-ps&WT.mc_id=M365-MVP-4012897)
[AdSense-B]
