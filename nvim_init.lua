-------------
-- Options --
-------------
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
-- wl-clipboard package is required.
vim.opt.clipboard = vim.opt.clipboard + 'unnamedplus'

----------------
-- Keymapping --
----------------
vim.g.mapleader = ' '
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<Esc><Esc>', '<cmd>nohlsearch<CR><Esc>')
vim.keymap.set('n', '<Leader>w', '<cmd>set wrap!<CR>')
vim.keymap.set('n', '<Leader>r', '<cmd>edit%<CR>') -- Reload current file.
-- buffer
vim.keymap.set('n', '<C-n>', '<cmd>bnext<CR><cmd>ls<CR>')
vim.keymap.set('n', '<C-p>', '<cmd>bprev<CR><cmd>ls<CR>')
vim.keymap.set('n', '<C-]>', '<cmd>bdelete%<CR>')          -- Delete current buffer.
vim.keymap.set('n', '<Leader><BS>', '<cmd>%bd|e#|bd#<CR>') -- Delete all buffers except current one.
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
-- Using lazy.nvim as the package manager.
-- (ref: https://github.com/folke/lazy.nvim#-installation)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Colorscheme
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme github_dark_colorblind')
    end
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<Leader>f', '<cmd>Telescope git_files<CR>' },
      { '<Leader>F', '<cmd>Telescope find_files<CR>' },
      { '<Leader>b', '<cmd>Telescope buffers<CR>' },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ['<C-r>'] = 'delete_buffer',                    -- Delete buffer with Ctrl-r.
              ['<C-u>'] = false,                              -- Delete input with Ctrl-u.
              ['<esc>'] = require('telescope.actions').close, -- Immediately close with Esc.
            },
          },
        },
      })
    end
  },

  -- LSP
  -- (ref: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/guides/lazy-loading-with-lazy-nvim.md)
  {
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v2.x',
      lazy = true,
      config = function()
        require('lsp-zero.settings').preset({})
      end
    },
    -- Autocompletion
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        {'L3MON4D3/LuaSnip'},
      },
      config = function()
        require('lsp-zero.cmp').extend()
      end
    },
    -- LSP
    {
      'neovim/nvim-lspconfig',
      cmd = 'LspInfo',
      event = {'BufReadPre', 'BufNewFile'},
      dependencies = {
        {'hrsh7th/cmp-nvim-lsp'},
        {'williamboman/mason-lspconfig.nvim'},
        {
          'williamboman/mason.nvim',
          build = function()
            pcall(vim.cmd, 'MasonUpdate')
          end,
        },
      },
      config = function()
        local lsp = require('lsp-zero')
        lsp.on_attach(function(client, bufnr)
          lsp.default_keymaps({buffer = bufnr})
        end)
        lsp.setup()
      end
    },
  },
})
