"---------------------------------------------------
" $B8+$?L\$K4X$9$k@_Dj(B
"---------------------------------------------------
"$B9T?t$rI=<($9$k(B
set number

"$B%U%!%$%k%(%s%3!<%G%#%s%0$dJ8;z%3!<%I$r%9%F!<%?%9%i%$%s$KI=<($9$k(B
set laststatus=2
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\

"$B%*!<%H%$%s%G%s%H$9$k(B
set autoindent
set shiftwidth=4

"$B2hLL$N1&C<$G@^$jJV$5$J$$(B
set nowrap

"$B%U%!%$%k%?%$%W$rG'<1$9$k(B
syntax on
filetype on
autocmd FileType c set cindent
autocmd FileType cpp set cindent

"--------------------------------------------------- 
"---------------------------------------------------
"$B%U%!%$%k$rJQ99$9$k$H$-%P%C%/%"%C%W$r$H$k(B
set backup

set enc=utf-8
set fenc=utf-8
set fencs=iso-2022-jp,euc-jp,cp932

"---------------------------------------------------
" $BJ8;zNs$N8!:w$K$D$$$F(B
"---------------------------------------------------

"$B8!:w;~$KBgJ8;z$H>.J8;z$rL5;k$9$k(B
"$B$?$@$7!"8!:w$9$k8l$KBgJ8;z$,4^$^$l$k>l9g$O6hJL$9$k(B
set ignorecase
set smartcase

"$B%$%s%/%j%a%s%?%k%5!<%A$9$k(B
set incsearch

"$B8!:w;~$K%^%C%A$7$?J8;zNs$r%O%$%i%$%H$9$k(B
set hlsearch

"---------------------------------------------------
" $B%-!<%^%C%T%s%0(B
"---------------------------------------------------
imap <C-e> <ESC>


"---------------------------------------------------
" $BFC<l$JJ8;z$r6/D4I=<($9$k(B
"---------------------------------------------------

"Tab$BJ8;z(B(^)$B$d9TKv$NH>3Q%9%Z!<%9(B(~)$B$rI=<($9$k(B
set list
set listchars=tab:^\ ,trail:~

"colorscheme (~/.vim/colors $B$K(Bdownload$B$9$kI,MW$,$"$k(B
"git clone https://github.com/tomasr/molokai
colorscheme molokai
set t_Co=256
hi Comment ctermfg=LightYellow
hi Visual ctermbg=255



"---------------------------------------------------
"vim-latex$B$K4X$9$k@_Dj(B
"filetype plugin on
"filetype indent on
"set shellslash
"set grepprg=grep\ -nH\ $*
" $B%3%s%Q%$%k;~$K;HMQ$9$k%3%^%s%I(B
"let g:Tex_CompileRule_dvi = 'platex --interaction=nonstopmode $*' 
"let g:Tex_BibtexFlavor = 'jbibtex'
"let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'

" $B%U%!%$%k$N%S%e!<%o!<(B
"let g:Tex_ViewRule_dvi = 'xdvi'
"let g:tex_flavor='latex'
