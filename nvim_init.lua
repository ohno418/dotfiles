-------------
-- Options --
-------------
-- disable netrw in favor of nvim-tree.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- basics
vim.opt.number = true
vim.opt.history = 200
vim.opt.visualbell = true
vim.opt.cursorline = true
vim.cmd('highlight CursorLine cterm=underline gui=underline ctermbg=NONE guibg=NONE')

-- tab, indent
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

-- searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- file handling
vim.opt.confirm = true
vim.opt.swapfile = false

-- yank to clipboard
-- Install xclip package with the following setting.
vim.opt.clipboard = vim.opt.clipboard + 'unnamedplus'

----------------
-- Keymapping --
----------------
vim.g.mapleader = ' '
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-n>', 'gt')
vim.keymap.set('n', '<C-p>', 'gT')
vim.keymap.set('n', '<Leader>t', ':tabnew<CR>')
vim.keymap.set('n', '<Leader>c', ':tabclose<CR>')

-------------
-- Plugins --
-------------
-- Using packer (https://aur.archlinux.org/packages/nvim-packer-git).
-- To install packages, run `PackerSync`.
require('packer').startup(function(use)
  -- Colorscheme
  use 'NLKNguyen/papercolor-theme'
  vim.opt.background = 'dark'
  vim.cmd('colorscheme PaperColor')

  -- File explorer
  use 'nvim-tree/nvim-tree.lua'
  vim.keymap.set('n', '<Leader>e', ':NvimTreeToggle<CR>');
  vim.keymap.set('n', '<Leader>E', ':NvimTreeCollapse | NvimTreeRefresh | NvimTreeOpen<CR>');

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  vim.keymap.set('n', '<Leader>f', ':Telescope find_files<CR>')
  vim.keymap.set('n', '<Leader>b', ':Telescope buffers<CR>')

  -- Window resizing
  use 'simeji/winresizer'
  vim.g['winresizer_vert_resize'] = 3

  -- LSP (Node.js require)
  -- e.g. To install Rust server, `:CocInstall coc-rust-analyzer`.
  use {'neoclide/coc.nvim', branch = 'release'}
  -- use enter as confirm on coc menu
  vim.keymap.set('i', '<CR>', 'coc#pum#visible() ? coc#pum#confirm() : "<CR>"', {expr = true})
  -- jump to definition
  vim.keymap.set('n', '<Leader>d', '<Plug>(coc-definition)', {silent = true})
end)

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "<C-s>", action = "split" },
        { key = "s", action = "split" },
        { key = "c", action = "cd" },
        { key = "<C-r>", action = "collapse_all" },
      },
    },
  },
  renderer = {
    add_trailing = true,
    highlight_opened_files = "name",
    indent_width = 2,
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = false,
      },
    },
  },
  filters = {
    dotfiles = true,
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
})
