-------------
-- Options --
-------------
local options = {
  -- basics
  number = true,
  history = 200,
  visualbell = true,
  cursorline = true,
  mouse = '',
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
vim.keymap.set('c', 'fmt<CR>', '!go fmt %<CR><CR>')
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

  -- File explorer
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup({
        keymaps = {
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-s>"] = "actions.select_split",
          -- Disable in favor of moving window.
          ["<C-h>"] = false,
          ["<C-l>"] = false,
        },
      })
      vim.keymap.set('n', '<Leader>e', '<cmd>Oil<CR>', { desc = 'Open parent directory' })
    end
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<Leader>f', '<cmd>Telescope git_files<CR>' },
      { '<Leader>F', '<cmd>Telescope find_files<CR>' },
      { '<Leader>b', '<cmd>Telescope buffers<CR>' },
      { '<Leader>d', '<cmd>Telescope diagnostics<CR>' },
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
      require('ibl').setup()
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
      })
    end
  },
})

---------
-- LSP --
---------
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = args.buf })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = args.buf })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = args.buf })
  end,
})

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Disable inline error messages.
    virtual_text = false,
    -- Disable underline.
    underline = false,
  }
)

-- List of LSP servers --
-- Rust
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rust',
  callback = function()
    vim.lsp.start({
      name = 'rust-analyzer',
      cmd = {'rust-analyzer'},
      root_dir = vim.fs.dirname(vim.fs.find({'Cargo.toml'}, { upward = true })[1]),
    })
  end
})
-- TypeScript
vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  callback = function()
    vim.lsp.start({
      name = 'tsserver',
      cmd = {'typescript-language-server', '--stdio'},
      root_dir = vim.fn.getcwd(),
    })
  end
})
