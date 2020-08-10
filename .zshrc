##プロンプトの設定
#
autoload colors
colors
PROMPT="
%{$fg[blue]%}%/%{$reset_color%}%{$fg[red]%} >%{$reset_color%}%{$fg[yellow]%}>%{$reset_color%}%{$fg[green]%}> %{$reset_color%}"


##aliasの設定
#
alias ls="ls -G"
alias gls="gls --color"
alias ojt='oj t -c "python main.py" -d ./tests/'


# 確認する
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

## Atcoder のためのFunction群

# contest 開始時にディレクトリ等を作成する
# 第一引数にabc171など、コンテスト名を与える
function start () {
    acc new $1
    cd $1
}

# online-judge-tools によるテスト
# 引数にa, bなどの問題名を与える
function test () {
    oj t -c "python ./$1/main.py" -d $1/tests/
}

# Atcoder-cli による自動提出
# ~/{contest_name}/ の下に各問題用のディレクトリが生成されているとする
# 引数にa, bなどの問題名を与える
function submit () {
    cd $1
    problem=`pwd | xargs basename`
    contest=`echo $(basename $(pwd | xargs dirname)) | tr '[:upper:]' '[:lower:]'`
    echo "${contest:0:3}$problem" | acc s
    cd ..
}




# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

#autoload -Uz zmv
#alias zmv = 'noglob zmv -W'


##補完設定
#
autoload -U compinit
compinit

##コマンド履歴設定 
#
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data 


#autoload history-search-end
#zle -N history-beginning-search-backward-end history-search-end
#zle -N history-beginning-search-forward-end history-search-end
#bindkey "^p" history-beginning-search-backward-end
#bindkey "^n" history-beginning-search-forward-end
#bindkey "\\ep" history-beginning-search-backward-end
#bindkey "\\en" history-beginning-search-forward-end

#履歴ファイルに時刻を記録する
setopt extended_history

#コマンド履歴にhistoryコマンドを記録しない
setopt hist_no_store


# pecoを使ったhistory検索 (Ctrl+R)
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

##色の設定
#

export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# 補完時の色設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# 補完候補に色つける
autoload -U colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}"


##大文字と小文字を区別しない
#
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

##cdを入力せずにディレクトリ移動をする
#
setopt auto_cd

##ビープ音をならさない
#
setopt no_beep

##C-wで直前の/まで削除するように、単語境界にならない文字を指定
#
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

##補完候補を詰めて表示する
setopt list_packed

# コマンドのスペルチェックをする
setopt correct


## Git関係
# git ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # git 管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全て commit されてクリーンな状態
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git 管理されていないファイルがある状態
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add されていないファイルがある状態
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit されていないファイルがある状態
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}[$branch_name]"
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# プロンプトの右側にメソッドの結果を表示させる
RPROMPT='`rprompt-git-current-branch`'

# function precmd() {
#   if [ ! -z $TMUX ]; then
#       tmux refresh-client -S
#   fi
# }



#Path
# export PATH=/Applications/gnuplot.app:/Applications/gnuplot.app/bin:$PATH
# export PATH=/Applications/UpTeX.app/teTeX/bin:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion


# zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Ruby
[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
    eval "$(rbenv init -)"
