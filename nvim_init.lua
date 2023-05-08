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
-- wl-clipboard package is required.
vim.opt.clipboard = vim.opt.clipboard + 'unnamedplus'

----------------
-- Keymapping --
----------------
vim.g.mapleader = ' '
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<Esc><Esc>', '<cmd>nohlsearch<CR><Esc>')
-- buffer
vim.keymap.set('n', '<C-n>', '<cmd>bnext<CR>')
vim.keymap.set('n', '<C-p>', '<cmd>bprev<CR>')
vim.keymap.set('n', '<Leader><BS>', '<cmd>%bd|e#|bd#<CR>') -- Delete all buffers except current one.
vim.keymap.set('n', '<Leader>r', '<cmd>edit%<CR>') -- Reload current file.
vim.keymap.set('n', '<Leader>w', '<cmd>set wrap!<CR>')
-- move window
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')
-- resize window
vim.keymap.set('n', '=', '<cmd>vertical resize +5<CR>')
vim.keymap.set('n', '-', '<cmd>vertical resize -5<CR>')
vim.keymap.set('n', '+', '<cmd>horizontal resize +2<CR>')
vim.keymap.set('n', '_', '<cmd>horizontal resize -2<CR>')
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
vim.keymap.set('n', '<Leader>e', '<cmd>Lexplore<CR>')
vim.keymap.set('n', '<Leader>E', '<cmd>Lexplore %:p:h<CR>') -- open current dir
vim.g.netrw_browser_split = 4 -- open in a prior window
vim.g.netrw_altv = 1          -- open splits to the right
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20
vim.api.nvim_create_autocmd('filetype', {
  pattern = 'netrw',
  callback = function()
    local bind = function(lhs, rhs)
      vim.keymap.set('n', lhs, rhs, {remap = true, buffer = true})
    end

    bind('a', '%')          -- Add a new file.
    bind('r', 'R')          -- Rename a file.
    bind('o', '<CR>')       -- Open a file.
    bind('<C-l>', '<C-w>l') -- Move to left window.
    bind('-', '<cmd>vertical resize -5<CR>')
  end
})

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

-- fuzzy finder
require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['<C-r>'] = 'delete_buffer',
      },
    },
  },
})
vim.keymap.set('n', '<Leader>f', '<cmd>Telescope git_files<CR>')
vim.keymap.set('n', '<Leader>F', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<Leader>b', '<cmd>Telescope buffers<CR>')

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
