"---------------------------------------------------
" 見た目に関する設定
"---------------------------------------------------
"行数を表示する
set number

"ファイルエンコーディングや文字コードをステータスラインに表示する
set laststatus=2
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\

"オートインデントする
set autoindent
set shiftwidth=4

"画面の右端で折り返さない
set nowrap

"ファイルタイプを認識する
syntax on
filetype on
autocmd FileType c set cindent
autocmd FileType cpp set cindent

"--------------------------------------------------- 
"---------------------------------------------------
"ファイルを変更するときバックアップをとる
set backup

set enc=utf-8
set fenc=utf-8
set fencs=iso-2022-jp,euc-jp,cp932

"---------------------------------------------------
" 文字列の検索について
"---------------------------------------------------

"検索時に大文字と小文字を無視する
"ただし、検索する語に大文字が含まれる場合は区別する
set ignorecase
set smartcase

"インクリメンタルサーチする
set incsearch

"検索時にマッチした文字列をハイライトする
set hlsearch

"---------------------------------------------------
" キーマッピング
"---------------------------------------------------
imap <C-e> <ESC>


"---------------------------------------------------
" 特殊な文字を強調表示する
"---------------------------------------------------

"Tab文字(^)や行末の半角スペース(~)を表示する
set list
set listchars=tab:^\ ,trail:~

"colorscheme (~/.vim/colors にdownloadする必要がある
"git clone https://github.com/tomasr/molokai
colorscheme molokai
set t_Co=256
hi Comment ctermfg=LightYellow
hi Visual ctermbg=255



"---------------------------------------------------
"vim-latexに関する設定
"filetype plugin on
"filetype indent on
"set shellslash
"set grepprg=grep\ -nH\ $*
" コンパイル時に使用するコマンド
"let g:Tex_CompileRule_dvi = 'platex --interaction=nonstopmode $*' 
"let g:Tex_BibtexFlavor = 'jbibtex'
"let g:Tex_CompileRule_pdf = 'dvipdfmx $*.dvi'

" ファイルのビューワー
"let g:Tex_ViewRule_dvi = 'xdvi'
"let g:tex_flavor='latex'
