-------------
-- Options --
-------------
-- basics
vim.o.number = true
vim.o.history = 200
vim.o.visualbell = true
vim.o.cursorline = true
-- tab, indent
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.smartindent = true
vim.o.breakindent = true
-- searching
vim.o.ignorecase = true
vim.o.smartcase = true
-- file handling
vim.o.confirm = true
vim.o.swapfile = false
-- yank to clipboard
-- wl-clipboard package is required.
vim.o.clipboard = 'unnamedplus'

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
-- tab
vim.keymap.set('n', '<Leader>t', '<cmd>tabnew<CR>')
vim.keymap.set('n', '<Leader>c', '<cmd>tabclose<CR>')
vim.keymap.set('n', '<Leader>n', 'gt')
vim.keymap.set('n', '<Leader>p', 'gT')
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
    bind('q', '<cmd>q<CR>') -- Close netrw window.
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
    'bluz71/vim-moonfly-colors',
    name = 'moonfly',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme moonfly')
    end
  },

  -- tree-sitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "rust", "typescript" },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
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
