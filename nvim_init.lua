-------------
-- Options --
-------------
local options = {
  -- basics
  number = true,
  history = 200,
  visualbell = true,
  cursorline = true,
  colorcolumn = '80',
  mouse = '', -- Disable mouse.
  -- softwrap
  wrap = false,
  breakindent = true,
  -- tab, indent
  expandtab = true,
  tabstop = 4,
  shiftwidth = 2,
  softtabstop = 2,
  smartindent = true,
  -- searching
  ignorecase = true,
  smartcase = true,
  -- file handling
  confirm = true,
  swapfile = false,
  -- yank to clipboard
  -- wl-clipboard package is required.
  clipboard = 'unnamedplus',
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- Display "search hit BOTTOM" message on searching.
vim.opt.shortmess:append('S')

-----------------
-- Keymappings --
-----------------
vim.g.mapleader = ' '
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<Esc><Esc>', '<cmd>nohlsearch<CR><Esc>')
vim.keymap.set('n', '<Leader>w', '<cmd>set wrap!<CR>')
vim.keymap.set('n', '<Leader>r', '<cmd>edit%<CR>') -- Reload current file.
-- tabs
vim.keymap.set('n', '<Leader>t', '<cmd>tabnew<CR>')
vim.keymap.set('n', '<Leader>c', '<cmd>tabclose<CR>')
vim.keymap.set('n', '<C-n>', 'gt')
vim.keymap.set('n', '<C-p>', 'gT')
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
vim.keymap.set('n', 'gs', '^')
vim.keymap.set('n', 'gh', '0')
vim.keymap.set('n', 'gl', '$')
vim.keymap.set('n', 'gm', '%')

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
    'Shatur/neovim-ayu',
    lazy = false,
    priority = 1000,
    config = function()
      local ayu = require('ayu')
      local colors = require('ayu.colors')
      ayu.setup({
        dark = true,
        overrides = {
          VertSplit = { fg = colors.fg },
          CursorLine = { underline = true },
        },
      })
      ayu.colorscheme()
    end
  },

  -- tree-sitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'rust', 'typescript' },
        highlight = {
          enable = true,
        },
      })
    end
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<Leader>f', '<cmd>Telescope git_files theme=ivy<CR>' },
      { '<Leader>F', '<cmd>Telescope find_files theme=ivy<CR>' },
      { '<Leader>b', '<cmd>Telescope buffers theme=ivy<CR>' },
      { '<Leader>d', '<cmd>Telescope diagnostics theme=ivy<CR>' },
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

  -- indent lines
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('ibl').setup({
        -- Disable underline for current scope.
        scope = { enabled = false },
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')

      -- language servers
      lspconfig.rust_analyzer.setup({})
      lspconfig.clangd.setup({})
      lspconfig.tsserver.setup({})

      -- keymappings
      vim.keymap.set('n', 'K', vim.lsp.buf.hover)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition)
      vim.keymap.set('n', 'gf', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

      -- See `:help vim.diagnostic.config`.
      vim.diagnostic.config({
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = 'rounded' },
      })

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          -- Border for hover window.
          border = 'rounded',
        }
      )
    end
  },
  -- LSP server management
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup()
    end
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = {
          { name = 'nvim_lsp' },
        },
        -- Select nothing at first.
        preselect = cmp.PreselectMode.None,
      })
    end
  },
})

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
    bind('q', '<cmd>q<CR>') -- Close netrw window.
    bind('<C-l>', '<C-w>l') -- Move to left window.
    bind('-', '<cmd>vertical resize -5<CR>')
  end
})
