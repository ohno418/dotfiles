vim.g.mapleader = ' '

--------------------
-- Plugins
--------------------
-- Get nvim-packer from AUR. (ref: https://github.com/wbthomason/packer.nvim#quickstart)
-- `:PackerSync` to sync plugins.
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Color
  use 'ayu-theme/ayu-vim'
  vim.cmd('set termguicolors')
  vim.cmd('let ayucolor="dark"')
  vim.cmd('colorscheme ayu')

  -- File explorer
  use 'scrooloose/nerdtree'
  vim.keymap.set('n', '<Leader>n', ':NERDTreeToggle<CR>')
  vim.keymap.set('n', '<Leader>N', ':NERDTree<CR>')

  -- Fuzzy finder
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  vim.keymap.set('n', '<Leader>f', ':Telescope find_files<CR>')
  vim.keymap.set('n', '<Leader>b', ':Telescope buffers<CR>')

  -- Window resizing
  use 'simeji/winresizer'
  vim.g.winresizer_vert_resize = 3

  -- LSP (Node.js require)
  -- e.g. To install Rust server, `:CocInstall coc-rust-analyzer`.
  use {'neoclide/coc.nvim', branch = 'release'}
end)

--------------------
-- Options
--------------------
-- basics
vim.cmd('set number')
vim.cmd('set history=200')
vim.cmd('set visualbell')
vim.cmd('set cursorline')
vim.cmd('highlight CursorLine cterm=underline gui=underline ctermbg=NONE guibg=NONE')

-- tab, indent
vim.cmd('set expandtab')
vim.cmd('set tabstop=8')
vim.cmd('set shiftwidth=2')
vim.cmd('set softtabstop=2')
vim.cmd('set smartindent')

-- searching
vim.cmd('set ignorecase')
vim.cmd('set smartcase')

-- file handling
vim.cmd('set confirm')
vim.cmd('set noswapfile')

-- yank to clipboard
-- Install xclip package with the following setting.
vim.cmd('set clipboard+=unnamedplus')

--------------------
-- Key mappings
--------------------
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-n>', 'gt')
vim.keymap.set('n', '<C-p>', 'gT')
vim.keymap.set('n', '<Leader>t', ':tabnew<CR>')
vim.keymap.set('n', '<Leader>c', ':tabclose<CR>')
