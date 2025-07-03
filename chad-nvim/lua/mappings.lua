require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
local options = { silent = true }
-- Define your mappings in separate tables for each mode
local mappings = {
	n = {
		{ lhs = "<C-s>", rhs = "<ESC>:silent w!<CR>", opts = { silent = true, desc = "save file" } },
		{
			lhs = "<space>e",
			rhs = function()
				local oil = require('oil')
				oil.toggle_float()
				-- local MiniFiles = require('mini.files')
				-- MiniFiles.open(vim.fn.expand("%p"))
			end,
			opts = options,
		},
		-- {
		--   lhs = "<C-b>",
		--   rhs = "<cmd>NvimTreeToggle<CR>",
		--   opts = options,
		-- },
		{
			lhs = "<Tab>",
			rhs = "<cmd>bnext<CR>",
			opts = options,
		},
		{
			lhs = "bl",
			rhs = ":Gitsigns toggle_current_line_blame<CR>",
			opts = options
		},
		-- {
		--   lhs = '<C-w>',
		--   rhs = ':bd <CR>',
		--   opts = options,
		-- },
		{
			lhs = "<space>x",
			rhs = "<cmd>bd <CR>",
			opts = options,
		},
		{
			lhs = "<S-Tab>",
			rhs = "<cmd>bprev<CR>",
			opts = options,
		},
		{
			lhs = "<C-q>",
			rhs = "<cmd>xa<CR>",
			opts = options,
		},
		-- TELESCOPE MAPPINGS
		{
			lhs = "<space>ff",
			rhs = "<cmd>Telescope find_files<CR>",
			opts = options,
		},
		{
			lhs = "<space>fw",
			rhs = "<cmd>Telescope live_grep<CR>",
			opts = options,
		},
		{
			lhs = "<space>fb",
			rhs = "<cmd>Telescope buffers initial_mode=normal sort=lastused sort=mru<CR>",
			opts = options,
		},
		{
			lhs = "<space><space>",
			rhs = "<cmd>Telescope buffers initial_mode=normal sort=lastused sort=mru<CR>",
			opts = options,
		},
		{
			lhs = "<space>fr",
			rhs = "<cmd>Telescope resume initial_mode=normal sort=lastused sort=mru<CR>",
			opts = options,
		},

		-- harpoon mappings
		{
			lhs = "<space>a",
			rhs = "<cmd>lua require('harpoon.mark').add_file()<CR>",
			opts = options,
		},
		-- DBUI MAPPINGS
		{
			lhs = "<space>tdb",
			rhs = "<cmd>DBUIToggle<CR>",
			opts = options,
		},
		-- HOP
		{
			lhs = "<space>hw",
			rhs = "<cmd>HopWord<CR>",
			opts = {
				desc = "jump next word",
				silent = true,
			},
		},

		{
			lhs = "<space>hc",
			rhs = "<cmd>HopChar1<CR>",
			opts = {
				desc = "jump  char",
				silent = true,
			},
		},
		{
			lhs = "<space>hl",
			rhs = "<cmd>HopLine<CR>",
			opts = {
				desc = "jump  line",
				silent = true,
			},
		},
		{
			lhs = "<space>dn",
			rhs = "<cmd>NoiceDismiss<CR>",
			opts = {
				silent = true,
				desc = "Dismiss Notification messages",
			},
		},
	},
	i = {
		{ lhs = "<C-s>", rhs = "<ESC>:silent w!<CR><ESC>", opts = { silent = true, desc = "save file" } },
		{
			lhs = "<C-q>",
			rhs = ":qa<CR>",
			opts = { desc = "quite all", silent = true },
		},
		{
			lhs = "<C-x>",
			rhs = function()
				local ls = require "luasnip"
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end,
		},
	},
}

vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev { severity = {
		min = vim.diagnostic.severity.HINT,
	} }
end, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next {
		severity = {
			min = vim.diagnostic.severity.HINT,
		},
	}
end, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "[e", function()
	vim.diagnostic.goto_next {
		severity = {

			min = vim.diagnostic.severity.ERROR,
		},
	}
end, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]e", function()
	vim.diagnostic.goto_prev { severity = { min = vim.diagnostic.severity.ERROR } }
end, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<space>k", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "gh", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- to disable changing the registers
vim.keymap.set({ "n", "v" }, "d", [["0d]], { noremap = true })
-- delete without copying to clipboard
vim.keymap.set({ "n", "v" }, "<space>d", [["_d]], { noremap = true })
-- change without copying to clipboard
vim.keymap.set({ "n", "v" }, "c", [["_c]], { noremap = true })
-- map({ "n", "v" }, "ciw", [["_ciw]])
-- delete without copying to clipboard
map({ "n", "v" }, "x", [["_x]])
-- paste without clearing the clipboard
map({ "n", "v" }, "p", [["0p]])
-- map({ "n", "v" }, "y", [[y]], {
-- 	remap = true,
-- 	silent = true,
-- 	desc = "paste  with space"
-- })

-- paste from system clipboard
vim.keymap.set({ "n", "v" }, "<space>p", function()
	vim.cmd("normal! a ")
	vim.cmd([[normal!"0p]])
end, {
	-- noremap = false,
	remap = true,
	silent = true,
	desc = "paste  with space"
})
-- vim.api.nvim_set_keymap('n', '<leader>p', ':normal! a <ESC> "0p ', { noremap = true, silent = true })



-- Function to set mappings for a given mode
local function set_mode_mappings(mode, mode_mappings)
	for _, mapping in ipairs(mode_mappings) do
		vim.keymap.set(mode, mapping.lhs, mapping.rhs, mapping.opts or {})
	end
end
-- Example of setting mappings for different modes
local function setup_mappings()
	for mode, mode_mappings in pairs(mappings) do
		set_mode_mappings(mode, mode_mappings)
	end
end

-- local nmap = function(keys, func, desc)
-- 	if desc then
-- 		desc = "LSP: " .. desc
-- 	end
--
-- 	vim.keymap.set("n", keys, func, { desc = desc })
-- end


-- See `:help K` for why this keymap
-- nmap("K", vim.lsp.buf.hover, "Hover Documentation")

-- Lesser used LSP functionality
-- Call the setup function to load the mappings
setup_mappings()
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
