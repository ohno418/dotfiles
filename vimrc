"******************************
" PluginManaging (vim-plug)
"******************************
" vim-plug is distributed as a single Vimscript file.
" All you have to do is to download the file in a directory so that Vim can load it.
" $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'scrooloose/nerdtree'                      " Source tree
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion
Plug 'dense-analysis/ale'                       " Linter
Plug 'vim-airline/vim-airline'                  " Status bar
Plug 'simeji/winresizer'                        " Window resizing
Plug 'fatih/molokai'                            " Colorscheme

Plug 'slim-template/vim-slim'
Plug 'leafgarland/typescript-vim'
" List ends here. Plugins become visible to Vim after this call.
" Run :PlugInstall to install the plugins.
call plug#end()

"******************************
" Basic & Display Setup
"******************************
syntax on
colorscheme molokai

" encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" file dealing
set confirm          " 保存されていないファイルがあるときは終了前に保存確認
set hidden           " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread         " 外部でファイルに変更がされた場合は読みなおす
set nobackup         " ファイル保存時にバックアップファイルを作らない
set noswapfile       " ファイル編集中にスワップファイルを作らない

" tab, indent
set expandtab        " タブ入力を複数の空白入力に置き換える
set tabstop=2        " 画面上でタブ文字が占める幅
set shiftwidth=2     " 自動インデントでずれる幅
set softtabstop=2    " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent       " 改行時に前の行のインデントを継続する
set smartindent      " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する

" searching
set hlsearch
set incsearch
set ignorecase
set smartcase        " 大文字小文字を両方含んだ検索の場合のみ、大文字小文字を区別

set ttyfast          " 高速ターミナル接続を行う
set history=200      " コマンド履歴を保存
set visualbell t_vb= " ビープ音を無効にする
set noerrorbells     " エラーメッセージの表示時にビープ音を鳴らさない
set number
set cursorline       " カーソル行にアンダーラインを表示する
set showmatch        " 対応する括弧を強調表示

set clipboard+=unnamed         " Yank to clipboard
set backspace=indent,eol,start " Fix backspace indent

"******************************
" KeyMapping
"******************************
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>
nnoremap Y y$
nnoremap <C-n> gt
nnoremap <C-p> gT
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
inoremap jj <ESC>
cnoremap nnn NERDTree<CR>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
