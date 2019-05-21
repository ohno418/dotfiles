"*****************************************************************************
"" Basic & Display Setup
"*****************************************************************************"
"" encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
set ttyfast

"" file dealing
set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   " 外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない

"" tab, indent
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=2     " 画面上でタブ文字が占める幅
set shiftwidth=2  " 自動インデントでずれる幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する

"" yank to clipboard
set clipboard+=unnamed

"" fix backspace indent
set backspace=indent,eol,start

"" searching
set hlsearch
set incsearch  " インクリメンタルサーチ
set ignorecase " 大文字小文字の区別をせずに検索
set smartcase  " 大文字小文字を両方含んだ検索の場合のみ、大文字小文字を区別

set history=200 " コマンド履歴を保存
set visualbell t_vb=
set noerrorbells "エラーメッセージの表示時にビープを鳴らさない

set number
set cursorline     " カーソル行の背景色を変える
set showmatch      " 対応する括弧を強調表示

set path+=app/controllers/**
colorscheme darkblue

" when vim start
autocmd BufRead,BufNewFile *.slim setfiletype slim

"""""""""""""""""""""""""""
"" KeyMapping
"""""""""""""""""""""""""""
inoremap jj <ESC>
cnoremap nnn NERDTree<CR><ESC>

"" clean highlight
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>

"" switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

nnoremap Y y$

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

nnoremap <C-n> gt
nnoremap <C-p> gT

"dein Scripts-----------------------------
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#add('~/.cache/dein')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('slim-template/vim-slim')

  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable
"End dein Scripts-------------------------
