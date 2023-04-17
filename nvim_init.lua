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
vim.opt.wrap = false

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
vim.keymap.set('n', '<C-n>', ':bnext<CR>')
vim.keymap.set('n', '<C-p>', ':bprev<CR>')
vim.keymap.set('n', '<Leader>r', ':edit%<CR>') -- Reload current file.
vim.keymap.set('n', '<Leader>w', ':set wrap!<CR>')
-- match mode
vim.keymap.set('n', 'mm', '%')
vim.keymap.set('n', 'mi', 'vi')
vim.keymap.set('n', 'ma', 'va')
-- goto mode
vim.keymap.set('n', 'gh', '0')
vim.keymap.set('n', 'gs', '_')
vim.keymap.set('n', 'gl', '$')
vim.keymap.set('n', 'ge', 'G')
vim.keymap.set('v', 'gh', '0')
vim.keymap.set('v', 'gs', '_')
vim.keymap.set('v', 'gl', '$h')
vim.keymap.set('v', 'ge', 'G')

-------------
-- Plugins --
-------------
-- Using packer (https://aur.archlinux.org/packages/nvim-packer-git).
-- To install packages, run `PackerSync`.
require('packer').startup(function(use)
  -- Colorscheme
  use 'ayu-theme/ayu-vim'
  vim.opt.termguicolors = true
  vim.g['ayucolor'] = 'dark'
  vim.cmd('colorscheme ayu')

  -- File explorer
  use 'nvim-tree/nvim-tree.lua'
  vim.keymap.set('n', '<Leader>e', ':NvimTreeToggle<CR>');
  vim.keymap.set('n', '<Leader>E', ':NvimTreeCollapse | NvimTreeRefresh | NvimTreeOpen<CR>');

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  vim.keymap.set('n', '<Leader>f', ':Telescope git_files<CR>')
  vim.keymap.set('n', '<Leader>b', ':Telescope buffers<CR>')
  vim.keymap.set('n', '<Leader>d', ':Telescope diagnostics<CR>')

  -- Bufferline
  use 'bling/vim-bufferline'

  -- Window resizing
  use 'simeji/winresizer'
  vim.g['winresizer_vert_resize'] = 3

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  }
end)

-- File explorer settings
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

-- LSP
-- To install a language server, run `:LspInstall` and restart nvim.
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()
