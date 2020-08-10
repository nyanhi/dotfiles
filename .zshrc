##$B%W%m%s%W%H$N@_Dj(B
#
autoload colors
colors
PROMPT="
%{$fg[blue]%}%/%{$reset_color%}%{$fg[red]%} >%{$reset_color%}%{$fg[yellow]%}>%{$reset_color%}%{$fg[green]%}> %{$reset_color%}"


##alias$B$N@_Dj(B
#
alias ls="ls -G"
alias gls="gls --color"
alias ojt='oj t -c "python main.py" -d ./tests/'


# $B3NG'$9$k(B
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

## Atcoder $B$N$?$a$N(BFunction$B72(B

# contest $B3+;O;~$K%G%#%l%/%H%jEy$r:n@.$9$k(B
# $BBh0l0z?t$K(Babc171$B$J$I!"%3%s%F%9%HL>$rM?$($k(B
function start () {
    acc new $1
    cd $1
}

# online-judge-tools $B$K$h$k%F%9%H(B
# $B0z?t$K(Ba, b$B$J$I$NLdBjL>$rM?$($k(B
function test () {
    oj t -c "python ./$1/main.py" -d $1/tests/
}

# Atcoder-cli $B$K$h$k<+F0Ds=P(B
# ~/{contest_name}/ $B$N2<$K3FLdBjMQ$N%G%#%l%/%H%j$,@8@.$5$l$F$$$k$H$9$k(B
# $B0z?t$K(Ba, b$B$J$I$NLdBjL>$rM?$($k(B
function submit () {
    cd $1
    problem=`pwd | xargs basename`
    contest=`echo $(basename $(pwd | xargs dirname)) | tr '[:upper:]' '[:lower:]'`
    echo "${contest:0:3}$problem" | acc s
    cd ..
}




# C $B$GI8=`=PNO$r%/%j%C%W%\!<%I$K%3%T!<$9$k(B
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


##$BJd40@_Dj(B
#
autoload -U compinit
compinit

##$B%3%^%s%IMzNr@_Dj(B 
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

#$BMzNr%U%!%$%k$K;~9o$r5-O?$9$k(B
setopt extended_history

#$B%3%^%s%IMzNr$K(Bhistory$B%3%^%s%I$r5-O?$7$J$$(B
setopt hist_no_store


# peco$B$r;H$C$?(Bhistory$B8!:w(B (Ctrl+R)
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

##$B?'$N@_Dj(B
#

export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# $BJd40;~$N?'@_Dj(B
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# $BJd408uJd$K?'$D$1$k(B
autoload -U colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}"


##$BBgJ8;z$H>.J8;z$r6hJL$7$J$$(B
#
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

##cd$B$rF~NO$;$:$K%G%#%l%/%H%j0\F0$r$9$k(B
#
setopt auto_cd

##$B%S!<%W2;$r$J$i$5$J$$(B
#
setopt no_beep

##C-w$B$GD>A0$N(B/$B$^$G:o=|$9$k$h$&$K!"C18l6-3&$K$J$i$J$$J8;z$r;XDj(B
#
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

##$BJd408uJd$r5M$a$FI=<($9$k(B
setopt list_packed

# $B%3%^%s%I$N%9%Z%k%A%'%C%/$r$9$k(B
setopt correct


## Git$B4X78(B
# git $B%V%i%s%AL>$r?'IU$-$GI=<($5$;$k%a%=%C%I(B
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # git $B4IM}$5$l$F$$$J$$%G%#%l%/%H%j$O2?$bJV$5$J$$(B
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # $BA4$F(B commit $B$5$l$F%/%j!<%s$J>uBV(B
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git $B4IM}$5$l$F$$$J$$%U%!%$%k$,$"$k>uBV(B
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add $B$5$l$F$$$J$$%U%!%$%k$,$"$k>uBV(B
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit $B$5$l$F$$$J$$%U%!%$%k$,$"$k>uBV(B
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # $B%3%s%U%j%/%H$,5/$3$C$?>uBV(B
    echo "%F{red}!(no branch)"
    return
  else
    # $B>e5-0J30$N>uBV$N>l9g(B
    branch_status="%F{blue}"
  fi
  # $B%V%i%s%AL>$r?'IU$-$GI=<($9$k(B
  echo "${branch_status}[$branch_name]"
}

# $B%W%m%s%W%H$,I=<($5$l$k$?$S$K%W%m%s%W%HJ8;zNs$rI>2A!"CV49$9$k(B
setopt prompt_subst

# $B%W%m%s%W%H$N1&B&$K%a%=%C%I$N7k2L$rI=<($5$;$k(B
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
