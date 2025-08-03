-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
-- 	callback = function()
-- 		MiniFiles.open(MiniFiles.get_latest_path())
-- 	end
-- })

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})
-- local preserve_cursor = augroup("PreserveCursor", {})
-- local open_dash = augroup("OpenDash", {})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank {
			higroup = "@comment.note",

			-- timeout = 100,
		}
	end,
})

autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local line = vim.fn.line "'\""
		if
			line > 1
			and line <= vim.fn.line "$"
			and vim.bo.filetype ~= "commit"
			and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
		then
			vim.cmd 'normal! g`"'
		end
	end,
})
-- get the content of the status line

-- vim.o.winbar = require('nvchad.stl.minimal')()
vim.o.winbar = [[%!v:lua.require('nvchad.stl.minimal')()]]
vim.o.stl = ""
vim.o.laststatus = 0
vim.o.cmdheight = 0
