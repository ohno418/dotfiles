-- OPTIONS --
local options = {
  -- basics
  number = true,
  history = 200,
  visualbell = true,
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
  list = true,
  listchars = 'tab:> ,lead:·,trail:·,nbsp:+',
  -- searching
  ignorecase = true,
  smartcase = true,
  -- file handling
  confirm = true,
  swapfile = false,
  -- yank to clipboard
  -- (wl-clipboard package is required for wayland.)
  clipboard = 'unnamedplus',
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- KEYMAPPINGS --
vim.g.mapleader = ' '
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<Esc><Esc>', '<cmd>nohlsearch<CR><Esc>')
vim.keymap.set('n', '<Leader>w', '<cmd>set wrap!<CR>')
-- buffers
vim.keymap.set('n', '<C-n>', '<cmd>bnext<CR>') -- Move to next.
vim.keymap.set('n', '<C-p>', '<cmd>bprev<CR>') -- Move to prev.
vim.keymap.set('n', '<Leader>d', '<cmd>bp|bd#<CR>') -- Delete current buffer and move to previous.
vim.keymap.set('n', '<Leader>r', '<cmd>edit%<CR>') -- Reload current buffer.
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

-- PLUGINS --
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
      ayu.setup({ dark = true })
      ayu.colorscheme()
    end
  },

  -- File explorer
  {
    'stevearc/oil.nvim',
    keys = {
      -- Open parent directory.
      { '<Leader>e', '<cmd>Oil<CR>' },
    },
    config = function()
      require('oil').setup({
        keymaps = {
          ['<C-v>'] = 'actions.select_vsplit',
          ['<C-s>'] = 'actions.select_split',
          -- Disable in favor of moving window.
          ['<C-h>'] = false,
          ['<C-l>'] = false,
        },
      })
    end
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<Leader>f', '<cmd>Telescope git_files<CR>' },
      { '<Leader>F', '<cmd>Telescope find_files<CR>' },
      { '<Leader>b', '<cmd>Telescope buffers<CR>' },
      { '<Leader><Space>', '<cmd>Telescope buffers<CR>' },
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local default_config = vim.tbl_extend(
        'force',
        require('telescope.themes').get_ivy(),
        {
          mappings = {
            i = {
              -- Delete input with Ctrl-u.
              ['<C-u>'] = false,
              -- Immediately close with Esc.
              ['<esc>'] = actions.close,
            },
            n = {
              ['<C-c>'] = actions.close,
            }
          },
          layout_config = {
            height = 0.8,
          },
        }
      )
      telescope.setup({
        defaults = default_config,
        pickers = {
          buffers = {
            mappings = {
              i = {
                -- Delete buffer with Ctrl-r.
                ['<C-r>'] = 'delete_buffer',
              },
            },
          },
        },
      })
    end
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = false,
          theme = 'auto',
          component_separators = { left = '|', right = '|'},
          section_separators = { left = '', right = ''},
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'searchcount' },
          lualine_c = {
            {
              'filename',
              path = 1,
            },
          },
          lualine_x = {},
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              'filename',
              path = 1,
            },
          },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
      }
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

  -- LSP
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')

      -- keymappings
      vim.keymap.set('n', 'K', vim.lsp.buf.hover)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition)
      vim.keymap.set('n', 'gf', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

      -- language servers
      lspconfig.rust_analyzer.setup({})
      lspconfig.clangd.setup({})
      lspconfig.tsserver.setup({})

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
