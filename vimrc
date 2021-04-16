let mapleader=" "

"*************
" Plugin
"*************
" vim-plug is distributed as a single Vimscript file.
" All you have to do is to download the file in a directory so that Vim can load it.
" $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" File explorer
Plug 'preservim/nerdtree'
nnoremap <Leader>n :NERDTree<CR>

" File searching
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = "<Leader><C-p>"
let g:ctrlp_working_path_mode = 0
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/dist/*,*.o

" Linter
Plug 'dense-analysis/ale'
let g:ale_set_highlights = 0

" Window resizing
Plug 'simeji/winresizer'
let g:winresizer_vert_resize = 3

" Syntax
Plug 'leafgarland/typescript-vim'

" List ends here. Plugins become visible to Vim after this call.
" Run :PlugInstall to install the plugins.
call plug#end()

"*************
" Basic setup
"*************
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
set backspace=indent,eol,start " Fix backspace indent

" tab, indent
set expandtab
set tabstop=4
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

" Searching
set hlsearch
highlight Search ctermbg=lightgreen
highlight Search ctermfg=black
set incsearch
set ignorecase
set smartcase

" File dealing
set confirm
set hidden
set autoread
set nobackup
set noswapfile

"*************
" KeyMapping
"*************
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
