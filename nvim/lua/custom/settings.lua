local opt = vim.opt
opt.relativenumber = true
opt.number = true
opt.scrolloff = 8
opt.colorcolumn = "100"
opt.wrap = false
opt.swapfile = false
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.smartindent = true
opt.hlsearch = false
opt.incsearch = true
opt.termguicolors = true
-- opt.term = 'xterm-256color'

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"


local vim = vim
local api = vim.api
local M = {}
function M.nvim_create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		api.nvim_command('augroup ' .. group_name)
		api.nvim_command('autocmd!')
		for _, def in ipairs(definition) do
			local command = table.concat(vim.tbl_flatten { 'autocmd', def }, ' ')
			api.nvim_command(command)
		end
		api.nvim_command('augroup END')
	end
end

local autoCommands = {
	-- other autocommands
	open_folds = {
		{ "FileReadPost,BufWinEnter,BufWritePost,BufEnter,BufReadPost", "*", "normal zR" }
	}
}

M.nvim_create_augroups(autoCommands)
