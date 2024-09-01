-- OPTIONS --
vim.opt.number = true
vim.opt.history = 200
vim.opt.visualbell = true
vim.opt.cursorline = true
vim.opt.colorcolumn = '80'
-- Disable mouse.
vim.opt.mouse = ''
-- softwrap
vim.opt.wrap = false
vim.opt.breakindent = true
-- tab, indent
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.listchars = {
    tab = '> ',
    lead = '-',
    trail = '-',
    nbsp = '+',
}
-- searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- file handling
vim.opt.confirm = true
vim.opt.swapfile = false
-- Yank to clipboard.
vim.opt.clipboard = 'unnamedplus'

-- KEYMAPPINGS --
vim.g.mapleader = ' '
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<Esc><Esc>', '<cmd>nohlsearch<CR><Esc>')
vim.keymap.set('n', '<Leader>w', '<cmd>set wrap!<CR>') -- Toggle soft wrap.
-- buffers
vim.keymap.set('n', '<C-n>', '<cmd>bnext<CR>') -- Move to next.
vim.keymap.set('n', '<C-p>', '<cmd>bprev<CR>') -- Move to prev.
vim.keymap.set('n', '<Leader>d', '<cmd>bp|bd#<CR>') -- Delete current buffer.
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

-- PLUGINS --
-- Bootstrap lazy.nvim plugin manager.
-- (ref: https://lazy.folke.io/installation)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none',
                              '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Colorscheme
  {
    'bluz71/vim-moonfly-colors',
    name = 'moonfly',
    config = function()
      vim.g.moonflyWinSeparator = 2
      vim.cmd('colorscheme moonfly')
    end,
  },

  -- File explorer
  {
    'stevearc/oil.nvim',
    keys = {
      -- Open parent directory.
      { '<Leader>e', '<cmd>Oil<CR>' },
    },
    config = function()
      local git_ignored = setmetatable({}, {
        __index = function(self, key)
          local result = vim.system(
            { 'git', 'ls-files', '--ignored', '--exclude-standard', '--others',
              '--directory' },
            {
              cwd = key,
              text = true,
            }
          ):wait()
          local ret = {}
          if result.code == 0 then
            local lines = vim.gsplit(result.stdout, '\n',
                                     { plain = true, trimempty = true })
            for line in lines do
              -- Remove trailing slash.
              line = line:gsub('/$', '')
              table.insert(ret, line)
            end
          end
          rawset(self, key, ret)
          return ret
        end,
      })

      local oil = require('oil')
      oil.setup({
        keymaps = {
          ['<C-v>'] = 'actions.select_vsplit',
          ['<C-s>'] = 'actions.select_split',
          -- Disable in favor of moving window.
          ['<C-h>'] = false,
          ['<C-l>'] = false,
        },
        view_options = {
          is_hidden_file = function(name, _)
            -- If no local directory (e.g. for ssh connections), always show.
            local dir = oil.get_current_dir()
            if not dir then
              return false
            end

            -- Hide dotfiles.
            if vim.startswith(name, '.') then
              return true
            end

            -- Hide git-ignored files.
            return vim.list_contains(git_ignored[dir], name)
          end,
        },
      })
    end,
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      -- file search
      { '<Leader>f', '<cmd>Telescope git_files<CR>' },
      { '<Leader>F', '<cmd>Telescope find_files<CR>' },
      -- buffer search
      { '<Leader>b',       '<cmd>Telescope buffers<CR>' },
      { '<Leader><Space>', '<cmd>Telescope buffers<CR>' },
      { '<C-a>',           '<cmd>Telescope buffers<CR>' },
      -- string grep
      { '<Leader>gg', '<cmd>Telescope live_grep<CR>' },
      -- git actions
      { '<Leader>gs', '<cmd>Telescope git_status<CR>' },
      { '<Leader>gc', '<cmd>Telescope git_bcommits<CR>' },
    },
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup({
        defaults = vim.tbl_extend(
          'force',
          require('telescope.themes').get_ivy(),
          {
            mappings = {
              i = {
                ['<C-f>'] = actions.results_scrolling_down,
                ['<C-b>'] = actions.results_scrolling_up,
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
        ),
        pickers = {
          buffers = {
            mappings = {
              i = {
                -- Delete buffer with Ctrl-r.
                ['<C-r>'] = actions.delete_buffer,
              },
            },
          },
          git_status = {
            mappings = {
              i = {
                ['<C-a>'] = actions.git_staging_toggle,
              },
            },
          },
        },
      })
    end,
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = false,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            {
              'buffers',
              show_filename_only = false,
              show_modified_status = false,
              symbols = {
                alternate_file = '',
                directory =  '',
              },
            },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
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
    end,
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
    end,
  },
  -- LSP server management
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup()
    end,
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
    end,
  },
})
