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
-- opt.foldcolumn = "auto"
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.inccommand = "split"
-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10
-- opt.hlsearch = true
-- opt.incsearch = true
opt.relativenumber = true
opt.colorcolumn = "100"
opt.wrap = false
opt.swapfile = false
opt.termguicolors = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.smartindent = true
opt.conceallevel = 1
opt.clipboard = "unnamedplus"
vim.g.mustache_abbreviations = 1

opt.cmdheight = 0

vim.opt.list = true
vim.opt.listchars = { tab = ". ", trail = "·", nbsp = "␣" }

opt.cursorline = true
opt.cursorlineopt = "both"
-- opt.term = "xterm-256color"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false -- Start with all folds open

-- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.g.loaded_node_provider = 0
vim.g.clipboard = 'unamedplus'

vim.g.clipboard = {
	name = "myClipboard",
	copy = {
		["+"] = { "wl-copy" },

		["*"] = { "wl-copy" },
	},
	paste = {

		["+"] = { "wl-paste" },

		["*"] = { "wl-paste" },
	},
	cache_enabled = 1,
}

-- local signs = { Error = "✗", Warn = "!", Hint = "➤", Info = "ℹ" }
-- for type, icon in pairs(signs) do
-- 	local hl = "DiagnosticSign" .. type
-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
-- end
