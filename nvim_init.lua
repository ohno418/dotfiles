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
vim.keymap.set('n', '<Leader>w', ':set wrap!<CR>')

-------------
-- Plugins --
-------------
-- Using packer (https://aur.archlinux.org/packages/nvim-packer-git).
-- To install packages, run `PackerSync`.
require('packer').startup(function(use)
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
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  vim.keymap.set('n', '<Leader>f', ':Telescope find_files<CR>')
  vim.keymap.set('n', '<Leader>b', ':Telescope buffers<CR>')

  -- Bufferline
  use 'bling/vim-bufferline'

  -- Window resizing
  use 'simeji/winresizer'
  vim.g['winresizer_vert_resize'] = 3

  -- LSP
  use 'neovim/nvim-lspconfig'
end)

-- File explorer settings
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "<C-s>", action = "split" },
        { key = "s", action = "split" },
        { key = "c", action = "cd" },
        { key = "<C-r>", action = "collapse_all" },
      },
    },
  },
  renderer = {
    add_trailing = true,
    highlight_opened_files = "name",
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

---------
-- LSP --
---------
local lspconfig = require('lspconfig')

-- Rust
-- install: https://rust-analyzer.github.io/manual.html#rustup
-- enable rust-analyzer cmd: `ln -s $(rustup which rust-analyzer) ~/.cargo/bin`
lspconfig.rust_analyzer.setup({})
-- TypeScript
-- install: https://github.com/typescript-language-server/typescript-language-server#installing
lspconfig.tsserver.setup({})

vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<Leader>k', vim.lsp.buf.hover, opts)
  end,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      underline = false,
      virtual_text = false,
    }
  )
