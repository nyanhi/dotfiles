## ---------------------------------------------------
## 環境変数・パス設定
## ---------------------------------------------------
export LANG=ja_JP.UTF-8

# Homebrew PATH (Intel Mac / Apple Silicon Mac 自動判定)
if [[ -d /opt/homebrew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -d /usr/local ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# uv でインストールされたCLIツールへのパス
export PATH="$HOME/.local/bin:$PATH"


## ---------------------------------------------------
## Zsh 基本設定・補完
## ---------------------------------------------------
autoload -Uz colors && colors
autoload -Uz compinit && compinit

# 補完時の色設定と大文字・小文字の不区別
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# オプション設定
setopt auto_cd
setopt no_beep
setopt list_packed
setopt correct
setopt prompt_subst

# C-w で単語境界とみなさない文字
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# コマンド履歴設定 
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history
setopt extended_history
setopt hist_no_store


## ---------------------------------------------------
## プロンプト設定 (Git連携含む)
## ---------------------------------------------------
# Zsh標準の vcs_info による高速なGit表示
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:git:*' formats "%F{green}[%b]%u%c%f"
zstyle ':vcs_info:git:*' actionformats "%F{red}(%a)|[%b]%f"

# 左プロンプト（慣れ親しんだカラープロンプト）
PROMPT="%{$fg[blue]%}%/%{$reset_color%}%{$fg[red]%} >%{$reset_color%}%{$fg[yellow]%}>%{$reset_color%}%{$fg[green]%}> %{$reset_color%}"

# 右プロンプト（Gitブランチ名を表示）
RPROMPT='${vcs_info_msg_0_}'


## ---------------------------------------------------
## エイリアス設定
## ---------------------------------------------------
alias ls="ls -G"
alias gls="gls --color"

# 確認付きファイル操作
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# クリップボード連携グローバルエイリアス (Mac/Linux自動分岐)
if command -v pbcopy >/dev/null 2>&1; then
    # Mac
    alias -g C='| pbcopy'
elif command -v wl-copy >/dev/null 2>&1; then
    # Linux (Wayland)
    alias -g C='| wl-copy'
elif command -v xsel >/dev/null 2>&1; then
    # Linux (X11)
    alias -g C='| xsel --input --clipboard'
fi


## ---------------------------------------------------
## コマンド履歴検索 (fzf 優先、なければ peco)
## ---------------------------------------------------
function select-history() {
    local BUFFER_CMD
    if command -v fzf >/dev/null 2>&1; then
        BUFFER_CMD=$(history -n 1 | tail -r | fzf --query "$LBUFFER")
    elif command -v peco >/dev/null 2>&1; then
        BUFFER_CMD=$(history -n 1 | tail -r | peco --query "$LBUFFER")
    fi

    if [ -n "$BUFFER_CMD" ]; then
        BUFFER="$BUFFER_CMD"
        CURSOR=$#BUFFER
    fi
    zle clear-screen
}
zle -N select-history
bindkey '^r' select-history


## ---------------------------------------------------
## Atcoder 用 Function群
## ---------------------------------------------------
# contest 開始時にディレクトリ等を作成する
function start () {
    acc new "$1"
    cd "$1"
}

function cstart() {
    acc new "$1" --template cpp
    cd "$1"
}

# online-judge-tools によるテスト (python用)
function test () {
    if command -v uv >/dev/null 2>&1; then
        oj t -c "uv run python ./$1/main.py" -d "$1/tests/"
    else
        oj t -c "python ./$1/main.py" -d "$1/tests/"
    fi
}

# cpp用テスト
function ojt () {
    g++ -std=c++17 ./$1/main.cpp && oj t -d "$1/tests/"
}

# Atcoder-cli による自動提出
function submit () {
    cd "$1" || return
    local problem=$(basename "$(pwd)")
    local contest=$(basename "$(dirname "$(pwd)")" | tr '[:upper:]' '[:lower:]')
    echo "${contest:0:3}$problem" | acc s
    cd ..
}

function sub () {
    cd "$1" || return
    local problem=$(basename "$(pwd)")
    local contest=$(basename "$(dirname "$(pwd)")" | tr '[:upper:]' '[:lower:]')
    echo "${contest:0:3}$problem" | acc s main.cpp
    cd ..
}


## ---------------------------------------------------
## 外部ツール・言語補完の設定
## ---------------------------------------------------
# uv のシェル補完を読み込み
if command -v uv >/dev/null 2>&1; then
    eval "$(uv generate-shell-completion zsh)"
    eval "$(uvx --generate-shell-completion zsh)"
fi

# NVM (Node.js) の読み込み
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# rbenv (Ruby) の読み込み
if [[ -d ~/.rbenv ]]; then
    export PATH="${HOME}/.rbenv/bin:${PATH}"
    eval "$(rbenv init -)"
fi

# zsh-syntax-highlighting (各環境のインストールパスに対応)
if [ -f "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
elif [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi