require "nvchad.options"

vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- add yours here!

local opt = vim.o

-- o.cursorlineopt ='both' -- to enable cursorline!
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.inccommand = "split"
-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10
opt.hlsearch = true
opt.relativenumber = true
opt.colorcolumn = "100"
opt.wrap = true
opt.swapfile = false
opt.termguicolors = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.smartindent = true
opt.incsearch = true
opt.conceallevel = 1
vim.g.mustache_abbreviations = 1

vim.opt.list = true
vim.opt.listchars = { tab = ". ", trail = "·", nbsp = "␣" }

opt.cursorline = true

opt.cursorlineopt = "both"
-- opt.term = "xterm-256color"

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.foldenable = false
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.g.loaded_node_provider = 0
