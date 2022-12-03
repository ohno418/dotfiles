let mapleader=" "

"=== Plugins ===
" vim-plug is distributed as a single Vimscript file.
" All you have to do is to download the file in a directory so that Vim can load it.
" ($ sh -c 'curl -fLo ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
" Then run :PlugInstall to install plugins.
call plug#begin('~/.vim/plugged')
    " Colorscheme
    Plug 'NLKNguyen/papercolor-theme'

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
    " use enter as confirm on coc menu
    inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
    " jump to definition
    nnoremap <silent> <Leader>d <Plug>(coc-definition)
call plug#end()

"=== Options ===
" color
set background=dark
colorscheme PaperColor

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

"=== File explorer (netrw) ===
nnoremap <Leader>e :Lexplore<CR>
" open in the directory of the current file
nnoremap <Leader>w :Lexplore %:p:h<CR>
let g:netrw_banner = 0
let g:netrw_keepdir = 0
let g:netrw_winsize = 15
" tree style
let g:netrw_liststyle = 3
" hide dotfiles
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
" TODO: ctrl-l to move left.
" TODO: o to open, instead of enter.
" TODO: v to vertical open, instead of enter.
" TODO: s to horizontal open, instead of enter.

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
