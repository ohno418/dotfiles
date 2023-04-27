-------------
-- Options --
-------------
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

-------------------------
-- Netrw file explorer --
-------------------------
vim.keymap.set('n', '<Leader>e', ':Lexplore<CR>')
vim.g.netrw_liststyle = 3 -- treeview
vim.g.netrw_browser_split = 4 -- open in a prior window
vim.g.netrw_altv = 1 -- open splits to the right
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20

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
