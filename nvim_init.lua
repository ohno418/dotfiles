-- OPTIONS --
vim.opt.number = true
vim.opt.relativenumber = true
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
  leadmultispace = '▏ ',
  trail = '-',
  extends = '>',
}
-- searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- file handling
vim.opt.confirm = true
vim.opt.swapfile = false
-- Yank to clipboard.
vim.opt.clipboard = 'unnamedplus'
-- status line
vim.opt.statusline = '%{fnamemodify(expand("%"), ":~:.")} %m%=%l:%c %p%%'

-- KEYMAPPINGS --
vim.g.mapleader = ' '
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<Esc><Esc>', '<cmd>nohlsearch<CR><Esc>')
vim.keymap.set('n', '<Leader>n', '<cmd>set relativenumber!<CR>') -- Toggle relativenumber.
vim.keymap.set('n', '<Leader>w', '<cmd>set wrap!<CR>')           -- Toggle soft wrap.
-- buffers
vim.keymap.set('n', '<Leader>r', '<cmd>edit%<CR>') -- Reload current buffer.
-- tabs
vim.keymap.set('n', '<Leader>t', '<cmd>tabnew<CR>')
vim.keymap.set('n', '<C-n>', '<cmd>tabnext<CR>')
vim.keymap.set('n', '<C-p>', '<cmd>tabprev<CR>')
-- Move window.
vim.keymap.set('n', '<tab>', '<C-w><C-w>')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')
-- Resize window.
vim.keymap.set('n', '=', '<cmd>vertical resize +5<CR>')
vim.keymap.set('n', '-', '<cmd>vertical resize -5<CR>')
vim.keymap.set('n', '+', '<cmd>horizontal resize +2<CR>')
vim.keymap.set('n', '_', '<cmd>horizontal resize -2<CR>')

-- COMMANDS ---
-- Copy relative path of current buffer to clipboard.
vim.api.nvim_create_user_command(
  'CopyRelPath',
  function()
    local relpath = vim.fn.fnamemodify(vim.fn.expand('%'), ':.')
    vim.api.nvim_call_function('setreg', { '+', relpath })
  end,
  {}
)
vim.keymap.set('n', '<Leader>c', '<cmd>CopyRelPath<CR>')

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
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.moonflyWinSeparator = 2
      vim.cmd('colorscheme moonfly')
    end,
  },

  -- Tree-sitter
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { 'c', 'rust', 'ruby' },
        highlight = { enable = true },
        indent = { enable = true },
      })
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
      require('oil').setup({
        keymaps = {
          ['<C-v>'] = 'actions.select_vsplit',
          ['<C-s>'] = 'actions.select_split',
          -- Disable in favor of moving window.
          ['<C-h>'] = false,
          ['<C-l>'] = false,
        },
        view_options = {
          is_hidden_file = function(name, _)
            return vim.startswith(name, '.') or -- dotfiles
                   vim.endswith(name, '.o')     -- object files
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
      { '<Leader>f', '<cmd>Telescope git_files<CR>' },
      { '<Leader>F', '<cmd>Telescope find_files<CR>' },
      { '<Leader>g', '<cmd>Telescope live_grep<CR>' },
      { '<Leader>l', '<cmd>Telescope buffers<CR>' },
      { '<Leader>d', '<cmd>Telescope diagnostics<CR>' },
    },
    config = function()
      local actions = require('telescope.actions')
      require('telescope').setup({
        defaults = require('telescope.themes').get_ivy({
          mappings = {
            i = {
              ['<C-f>'] = actions.results_scrolling_down,
              ['<C-b>'] = actions.results_scrolling_up,
              -- Close with Esc, instead of going to normal mode.
              ['<Esc>'] = actions.close,
            },
            n = {
              ['<C-c>'] = actions.close,
            },
          },
          layout_config = { height = 0.8 },
        }),
        pickers = {
          buffers = {
            mappings = { i = { ['<C-r>'] = actions.delete_buffer } },
          },
        },
      })
    end,
  },

  -- Language server management
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup()
    end,
  },

  -- Autocompletion for LSP
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
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

-- LSP --
vim.keymap.set('n', 'K',  vim.lsp.buf.hover)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition)
vim.keymap.set('n', 'gf', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- Rust
vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
})
vim.lsp.enable('rust_analyzer')
