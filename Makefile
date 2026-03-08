# =============================================================
# Hugo ブログ 運用コマンド集
# 使い方: make <ターゲット名>
# =============================================================

STORAGE_ACCOUNT ?= your-storage-account   # 環境変数で上書き可
RESOURCE_GROUP  ?= rg-my-blog

.PHONY: help init server build deploy new clean

# デフォルト: ヘルプ表示
help:
	@echo "使用可能なコマンド:"
	@echo "  make init            初回セットアップ（テーマの submodule 取得）"
	@echo "  make server          ローカル開発サーバー起動（http://localhost:1313）"
	@echo "  make server-draft    下書き記事も含めてローカルサーバー起動"
	@echo "  make build           本番用ビルド（public/ に出力）"
	@echo "  make deploy          Azure Blob Storage にデプロイ"
	@echo "  make new TITLE=xxx   新しい記事を作成"
	@echo "  make clean           public/ と resources/ を削除"

# 初回セットアップ
init:
	git submodule update --init --recursive
	@echo "✅ テーマの取得完了"

# ローカルサーバー（下書き非表示）
server:
	hugo server --bind 0.0.0.0 -p 1313

# ローカルサーバー（下書き含む）
server-draft:
	hugo server --buildDrafts --bind 0.0.0.0 -p 1313

# 本番ビルド
build: clean
	hugo --minify --gc
	@echo "✅ ビルド完了 → public/"

# Azure へデプロイ
deploy: build
	@echo "🚀 Azure Blob Storage にアップロード中..."
	az storage blob delete-batch \
		--account-name $(STORAGE_ACCOUNT) \
		--source '$$web' \
		--auth-mode login
	az storage blob upload-batch \
		--account-name $(STORAGE_ACCOUNT) \
		--source ./public \
		--destination '$$web' \
		--auth-mode login \
		--overwrite
	@echo "✅ デプロイ完了"
	@az storage account show \
		--name $(STORAGE_ACCOUNT) \
		--resource-group $(RESOURCE_GROUP) \
		--query "primaryEndpoints.web" \
		--output tsv

# 新記事作成
# 使い方: make new TITLE="azure-functions-intro"
new:
	hugo new posts/$(TITLE).md
	@echo "✅ content/posts/$(TITLE).md を作成しました"

# ビルド成果物の削除
clean:
	rm -rf public/ resources/
	@echo "🗑️  public/ と resources/ を削除しました"