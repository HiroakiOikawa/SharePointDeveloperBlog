#!/bin/bash
# SharePoint Developer Blog - Hugo + Stack Setup Script

BLOG_NAME="sharepoint-developer"

echo "=== SharePoint Developer Blog Setup ==="

# 1. Hugo サイト作成
hugo new site $BLOG_NAME
cd $BLOG_NAME

# 2. Git 初期化
git init

# 3. Stack テーマをサブモジュールとして追加
git submodule add https://github.com/CaiJimmy/hugo-theme-stack/ themes/hugo-theme-stack

# 4. Stack テーマのサンプルコンテンツをコピー
cp -r themes/hugo-theme-stack/exampleSite/content ./
cp -r themes/hugo-theme-stack/exampleSite/assets ./

# 5. 必要なディレクトリを作成
mkdir -p .github/workflows
mkdir -p layouts/_default
mkdir -p layouts/partials/head
mkdir -p layouts/partials/widget
mkdir -p assets/scss
mkdir -p static/img
mkdir -p content/about
mkdir -p content/archives
mkdir -p content/search
mkdir -p content/post/hello-world

echo ""
echo "=== Setup Complete! ==="
echo ""
echo "次のステップ:"
echo "  1. 各ファイルをフォルダに配置してください"
echo "  2. hugo.toml の baseURL を Azure SWA の URL に変更してください"
echo "  3. hugo.toml の AdSense ID を設定してください"
echo "  4. static/img/avatar.png にアバター画像を配置してください"
echo "  5. ローカル確認: hugo server -D"