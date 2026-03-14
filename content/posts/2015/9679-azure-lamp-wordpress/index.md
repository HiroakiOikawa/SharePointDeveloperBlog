---
title: "Azure 仮想マシンに LAMP 環境を構築し WordPress を立ち上げる -その３-"
description: "前回 までで LAMP 環境の構築まで完了したので、今回は MySQL のデータファイルをデータ領域として追加した仮想ディスクに移動する方法と、いくつか細かな設定をして、WordPress をインストールするための準備をします。 データ領域…"
date: 2015-02-21T22:51:54+09:00
slug: "9679-azure-lamp-wordpress"
categories: ["Azure"]
aliases: ["/article/9679/"]
draft: false
---
[前回](http://sharepoint.orivers.jp/article/9623 "Azure 仮想マシンに LAMP 環境を構築し WordPress を立ち上げる -その２-")までで LAMP 環境の構築まで完了したので、今回は MySQL のデータファイルをデータ領域として追加した仮想ディスクに移動する方法と、いくつか細かな設定をして、WordPress をインストールするための準備をします。

## データ領域用ディスクのマウント

仮想マシンに追加した仮想ディスクをマウントします。
1. データ領域用ディスクの初期化
TeraTarm でサーバーに接続して以下のコマンドを実行し、ディスクを初期化します。
```
sudo fdisk /dev/sdc
```
すると下記のようなメッセージが表示されます。
```
Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
Building a new DOS disklabel with disk identifier 0xf068a662.
Changes will remain in memory only, until you decide to write them.
After that, of course, the previous content won't be recoverable.
Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
Command (m for help): n
Partition type:
p primary (0 primary, 0 extended, 4 free)
e extended
Select (default p): p
Partition number (1-4, default 1): 1
First sector (2048-1048575999, default 2048):
Using default value 2048
Last sector, +sectors or +size{K,M,G} (2048-1048575999, default 1048575999):
Using default value 1048575999
Command (m for help): p
Disk /dev/sdc: 536.9 GB, 536870912000 bytes
255 heads, 63 sectors/track, 65270 cylinders, total 1048576000 sectors
Units = sectors of 1 \* 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xf068a662
Device Boot Start End Blocks Id System
/dev/sdc1 2048 1048575999 524286976 83 Linux
Command (m for help): w
The partition table has been altered!
Calling ioctl() to re-read partition table.
Syncing disks.
```
2. パーティション作成
以下のコマンドを実行し、パーティションを作成します。
```
sudo mkfs -t ext4 /dev/sdc1
```
3. マウント先のフォルダを作成
以下のコマンドを実行し、データ領域用ディスクをマウントするための「data」フォルダを作成します。
```
sudo mkdir /data
```
4. マウント
以下のコマンドを実行し、データ領域用ディスクを「data」フォルダにマウントします。
```
sudo mount /dev/sdc1 /data
```
5. 常時マウント
マウント設定が再起動後も維持されるよう vi で /etc/fstab を編集します。
```
sudo vi /etc/fstab
```
一番下の行に以下の一文を追加して保存してください。
```
/dev/sdc1 /data ext4 defaults,un
```

## MySQL のデータフォルダを移動

マウントした仮想ディスクに MySQL のデータフォルダを移動します。
1. 新しいデータフォルダを準備
MySQL を停止し、データ領域として追加したディスクをマウントした data フォルダに既存のデータファイルをコピーします。
```
sudo stop mysql
sudo cp -pR /var/lib/mysql /data/
sudo chown -R mysql:mysql /data/mysql
```
2. データフォルダの場所を変更
設定を変更しデータフォルダの場所を変更します。
```
sudo vi /etc/mysql/my.cnf
```
43行目あたりにある以下の設定を＜変更後＞の内容に変更します。
＜変更前＞
```
datadir = /var/lib/mysql
```
＜変更後＞
```
#datadir = /var/lib/mysql
datadir = /data/mysql
```
変更後のデータフォルダの権限を設定するため vi で設定ファイルを編集します。
```
sudo vi /etc/apparmor.d/usr.sbin.mysqld
```
一番下の行に以下の文を追加して保存してください。
```
/data/mysql r,
/data/mysql/\*\* rwk,
```
設定が済んだので MySQL を起動します。
```
sudo start mysql
```
無事起動すると以下のようなメッセージが表示されます。
```
mysql start/running, process 26941
```

## MySQL のセキュリティを高める

WordPress をインターネットに公開するため、MySQL の最低限のセキュリティ設定を行います。
1. セキュアインストールの実行
以下のコマンドを実行し、セキュア設定を行います。
```
/usr/bin/mysql\_secure\_installation
```
以下のメッセージが表示されたら、root のパスワードを入力します。
```
Enter current password for root (enter for none):
```
root のパスワードは変更しないので、n を入力します。
```
You already have a root password set, so you can safely answer 'n'.
Change the root password? [Y/n] n
```
以降、すべて y を指定します。
```
Remove anonymous users? [Y/n] y
Disallow root login remotely? [Y/n] y
Remove test database and access to it? [Y/n] y
Reload privilege tables now? [Y/n] y
```
2. phpMyAdmin の接続を制限する
phpMyAdmin をインストールしていなければ必要ないのですが、今回はインストールしてしまっているので、接続制限をかけます。
vi で apache.conf を編集します。
```
sudo vi /etc/phpmyadmin/apache.conf
```
<Directory /usr/share/phpmyadmin> の下の DirectoryIndex index.php の行の後に、以下の設定を加えます。
IP アドレスの部分(000.000.000.000 のところ) は接続を許可する IP アドレス (phpMyAdmin への接続を許可する PC のグローバル IP アドレス) を指定します。
```
order deny,allow
deny from all
allow from 000.000.000.000
```
これで WordPress をインストールする準備が整いました。
次回、ようやく WordPress のインストールです。
**関連記事：**
[Azure 仮想マシンに LAMP 環境を構築し WordPress を立ち上げる -その１-](http://sharepoint.orivers.jp/article/9572)
[Azure 仮想マシンに LAMP 環境を構築し WordPress を立ち上げる -その２-](http://sharepoint.orivers.jp/article/9623)
[Azure 仮想マシンに LAMP 環境を構築し WordPress を立ち上げる -その３-](http://sharepoint.orivers.jp/article/9679)
[Azure 仮想マシンに LAMP 環境を構築し WordPress を立ち上げる -その４-](http://sharepoint.orivers.jp/article/9711)
