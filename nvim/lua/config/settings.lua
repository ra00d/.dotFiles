local opt = vim.opt
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
opt.number = true
opt.mouse = 'a'
opt.showmode = false

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = 'yes'
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.list = true
-- opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.inccommand = 'split'
opt.cursorline = true
-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10
opt.hlsearch = true
opt.relativenumber = true
opt.colorcolumn = '100'
opt.wrap = true
opt.swapfile = false
opt.termguicolors = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.smartindent = true
opt.incsearch = true
opt.clipboard = 'unnamedplus'
opt.conceallevel = 1
vim.g.mustache_abbreviations = 1
-- opt.term = 'xterm-256color'

opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'

opt.foldenable = false
vim.g.clipboard = {
  name = 'WslClipboard',
  copy = {
    ['+'] = 'clip.exe',
    ['*'] = 'clip.exe',
  },
  paste = {
    ['+'] = 'pwsh.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    ['*'] = 'pwsh.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  },
  cache_enabled = 0,
}
-- vim.g.clipboard = {
--   name = 'myClipboard',
--   copy = {
--     ['+'] = { 'tmux', 'load-buffer', '-' },
--     ['*'] = { 'tmux', 'load-buffer', '-' },
--   },
--   paste = {
--     ['+'] = { 'tmux', 'save-buffer', '-' },
--     ['*'] = { 'tmux', 'save-buffer', '-' },
--   },
--   cache_enabled = 1,
-- }
