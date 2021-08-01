let mapleader=" "

" vim-plug is distributed as a single Vimscript file.
" All you have to do is to download the file in a directory so that Vim can load it.
" ($ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)
" Then run :PlugInstall to install plugins.
call plug#begin('~/.vim/plugged')
    " File explorer
    Plug 'preservim/nerdtree'
    nnoremap <Leader>n :NERDTree<CR>

    " File search
    Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_map = "<Leader><C-p>"
    let g:ctrlp_working_path_mode = 0
    set wildignore+=*.o,*.swp,*/tmp/*,*/target/*,*/node_modules/*,*/dist/*

    " Linter
    Plug 'dense-analysis/ale'

    " Window resizing
    Plug 'simeji/winresizer'
    let g:winresizer_vert_resize = 3

    " Colorscheme
    Plug 'jaredgorski/spacecamp'

    " Syntax
    Plug 'leafgarland/typescript-vim'
call plug#end()

" basics
colorscheme spacecamp
syntax enable
filetype plugin on
set number
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast
set history=200
set visualbell t_vb=
set noerrorbells
set cursorline
set backspace=indent,eol,start " Fix <BS> behavior
set clipboard=unnamedplus      " Yank to clipboard

" tab, indent
set expandtab
set tabstop=8
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
highlight Search ctermbg=LightGreen ctermfg=Black
highlight MatchParen ctermbg=DarkGray ctermfg=LightGreen

" File handling
set confirm
set hidden
set autoread
set nobackup
set noswapfile

inoremap jj <ESC>
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-n> gt
nnoremap <C-p> gT
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>c :tabclose<CR>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
