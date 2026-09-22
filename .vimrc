"---------------------------------------------------
" 基本・エンコーディング設定
"---------------------------------------------------
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932
set scriptencoding=utf-8

"---------------------------------------------------
" 見た目・表示設定
"---------------------------------------------------
set number
set nowrap
set list
set listchars=tab:^\ ,trail:~

" ステータスラインの設定
set laststatus=2
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\

" カラー設定
syntax on
filetype plugin indent on

" 256色・True Color対応
if has('termguicolors')
  set termguicolors
endif
set t_Co=256

" molokaiが存在する場合のみ読み込む（エラー防止）
silent! colorscheme molokai
hi Comment ctermfg=LightYellow
hi Visual ctermbg=255

"---------------------------------------------------
" インデント・検索設定
"---------------------------------------------------
set autoindent
set shiftwidth=4
set tabstop=4
set expandtab

set ignorecase
set smartcase
set incsearch
set hlsearch

" バックアップ設定
set backup

"---------------------------------------------------
" キーマッピング
"---------------------------------------------------
" 慣れ親しんだキーバインド
imap <C-e> <ESC>