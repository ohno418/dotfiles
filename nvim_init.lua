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
vim.keymap.set('n', '<Leader><BS>', ':%bd|e#|bd#<CR>') -- Delete all buffers except current one.
vim.keymap.set('n', '<Leader>r', ':edit%<CR>') -- Reload current file.
vim.keymap.set('n', '<Leader>w', ':set wrap!<CR>')
-- goto mode
vim.keymap.set('n', 'gh', '0')
vim.keymap.set('n', 'gs', '_')
vim.keymap.set('n', 'gl', '$')
vim.keymap.set('v', 'gh', '0')
vim.keymap.set('v', 'gs', '_')
vim.keymap.set('v', 'gl', '$')

-------------
-- Plugins --
-------------
-- Using packer as the package manager.
--
-- To install packer, run:
-- `git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim`.
-- (https://github.com/wbthomason/packer.nvim#quickstart)
--
-- To install packages, run `PackerSync`.
require('packer').startup(function(use)
  -- Packer itself
  use 'wbthomason/packer.nvim'

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
  vim.keymap.set('n', '<Leader>F', ':Telescope find_files<CR>')
  vim.keymap.set('n', '<Leader>b', ':Telescope buffers<CR>')
  vim.keymap.set('n', '<Leader>d', ':Telescope diagnostics<CR>')

  -- bufferline
  use {'akinsho/bufferline.nvim', tag = '*'}

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
local function on_attach_nvim_tree(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return {
      desc = 'nvim-tree: ' .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  vim.keymap.set('n', 'o',     api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-s>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', 'c', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '<C-r>', api.tree.collapse_all, opts('Collapse'))
  vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
end

require('nvim-tree').setup({
  on_attach = on_attach_nvim_tree,
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
  },
  renderer = {
    add_trailing = true,
    highlight_opened_files = 'name',
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

-- bufferline
local bufferline = require('bufferline')
bufferline.setup({
  options = {
    show_buffer_close_icons = false,
    always_show_bufferline = false,
  },
})

-- LSP
-- To install a language server, run `:LspInstall` and restart nvim.
local lsp = require('lsp-zero').preset({})
lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})

  -- custom keybindings
  vim.keymap.set('n', 'gf', vim.diagnostic.open_float)
end)
lsp.setup()
