"******************************
" Basic & Display Setup
"******************************
" encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
set ttyfast

" file dealing
set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   " 外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない

" tab, indent
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=2     " 画面上でタブ文字が占める幅
set shiftwidth=2  " 自動インデントでずれる幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する

" yank to clipboard
set clipboard+=unnamed

" fix backspace indent
set backspace=indent,eol,start

" searching
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

"******************************
" KeyMapping
"******************************
inoremap jj <ESC>
cnoremap nnn NERDTree<CR><ESC>

" clean highlight
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>

" switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

nnoremap Y y$

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

nnoremap <C-n> gt
nnoremap <C-p> gT

"******************************
" PluginManaging (vim-plug)
"******************************
" vim-plug is distributed as a single Vimscript file.
" All you have to do is to download the file in a directory so that Vim can load it.
" $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'simeji/winresizer'

Plug 'slim-template/vim-slim'
Plug 'leafgarland/typescript-vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Run :PlugInstall to install the plugins.
