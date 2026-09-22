#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# シンボリックリンクの作成
bash "${DOTFILES_DIR}/install.sh"

OS_TYPE="$(uname)"

if [ "$OS_TYPE" = "Linux" ]; then
    echo "Setting up Ubuntu environment..."
    sudo apt update
    sudo apt install -y \
        build-essential \
        curl \
        git \
        tmux \
        vim \
        zsh \
        xclip

    # zsh をデフォルトシェルに変更
    if [ "$SHELL" != "$(which zsh)" ]; then
        chsh -s "$(which zsh)"
    fi

elif [ "$OS_TYPE" = "Darwin" ]; then
    echo "Setting up macOS environment..."
    if ! command -v brew >/dev/null 2>&1; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install tmux vim zsh node
fi

# ---------------------------------------------------
# uv のインストール
# ---------------------------------------------------
if ! command -v uv >/dev/null 2>&1; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# パスを一時的に通して uv を利用可能にする
export PATH="$HOME/.local/bin:$PATH"

# ---------------------------------------------------
# AtCoder関連ツールのセットアップ
# ---------------------------------------------------
#echo "Installing competitive programming tools via uv & npm..."
# online-judge-tools を uv で安全かつ高速にツール化
uv tool install online-judge-tools

# atcoder-cli
#if [ "$OS_TYPE" = "Linux" ]; then
#    sudo npm install -g atcoder-cli || npm install -g atcoder-cli
#else
#    npm install -g atcoder-cli
#fi

# ---------------------------------------------------
# zsh-syntax-highlighting の導入
# ---------------------------------------------------
ZSH_HIGHLIGHT_DIR="${HOME}/.zsh/zsh-syntax-highlighting"
if [ ! -d "$ZSH_HIGHLIGHT_DIR" ]; then
    echo "Cloning zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_HIGHLIGHT_DIR"
fi

echo "Setup completed successfully!"
