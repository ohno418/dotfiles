let mapleader=" "

"=== Plugins ===
" vim-plug is distributed as a single Vimscript file.
" All you have to do is to download the file in a directory so that Vim can load it.
" ($ sh -c 'curl -fLo ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
" Then run :PlugInstall to install plugins.
call plug#begin('~/.vim/plugged')
    " Colorscheme
    Plug 'NLKNguyen/papercolor-theme'

    " File explorer
    Plug 'scrooloose/nerdtree'
    nnoremap <Leader>n :NERDTreeToggle<CR>
    nnoremap <Leader>N :NERDTree<CR>

    " Fuzzy finder
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    nnoremap <Leader>f :Telescope find_files<CR>
    nnoremap <Leader>b :Telescope buffers<CR>

    " Window resizing
    Plug 'simeji/winresizer'
    let g:winresizer_vert_resize = 3

    " LSP (Node.js require)
    " e.g. To install Rust server, `:CocInstall coc-rust-analyzer`.
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
call plug#end()

"=== Options ===
" color
set termguicolors
set background=dark
colorscheme PaperColor
" coc: selected color on menu
highlight CocMenuSel guibg=DarkGreen

" basics
set number
set history=200
set visualbell
set cursorline
highlight CursorLine cterm=underline gui=underline ctermbg=NONE guibg=NONE

" tab, indent
set expandtab
set tabstop=4
set shiftwidth=2
set softtabstop=2
set smartindent

" searching
set ignorecase
set smartcase

" file handling
set confirm
set noswapfile

" yank to clipboard
" Install xclip package with the following setting.
set clipboard+=unnamedplus

"=== Key mappings ===
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
