# Dotfiles

macOS (Intel / Apple Silicon) および Ubuntu 環境で共有・使用するDotfiles構成です。  
`uv` を用いた高速なPythonツールの導入や、AtCoder（競技プログラミング）のセットアップを自動化しています。

---

## 🚀 新しい環境でのセットアップ手順 (Ubuntu / macOS)

新しいPCまたは再構築したOS（Ubuntu等）でターミナルを開き、以下のコマンドを順番に実行してください。

```bash
# 1. リポジトリのクローン
git clone https://github.com/nyanhi/dotfiles.git ~/.dotfiles

# 2. ディレクトリへ移動
cd ~/.dotfiles

# 3. セットアップスクリプトの実行
bash setup.sh
