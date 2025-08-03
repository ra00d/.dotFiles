-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua
--
local utils = require('nvchad.stl.utils')
local sep_l = utils.separators.block.left
local sep_r = "%#St_sep_r#" .. utils.separators.block.right .. " %#ST_EmptySpace#"


local function gen_block(icon, txt, sep_l_hlgroup, iconHl_group, txt_hl_group)
	return sep_l_hlgroup .. sep_l .. iconHl_group .. icon .. " " .. txt_hl_group .. " " .. txt .. sep_r
end
local M =
--@class ChadrcConfig
{}
M.ui = {

	tabufline = {
		enabled = false,
	},

	lsp = { signature = true },

	cheatsheet = {
		theme = "grid",                                               -- simple/grid
		excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
	},

	mason = { pkgs = {} },

	colorify = {
		enabled = true,
		mode = "virtual", -- fg, bg, virtual
		virt_text = "󱓻 ",
		highlight = { hex = true, lspvars = true },
	},

	statusline = {
		theme = "minimal",
		winbar = {
			lualine_a = { 'filename' },
			lualine_b = { 'branch' },
			lualine_c = { '%l/%L %p%%' },
		},
		separator_style = "block",
		order = { "mode", 'file', 'git', 'recording', "%=", 'lsp_msg', "%=", "diagnostics", 'lsp', 'path', 'cursor' },
		modules = {
			lsp = function()
				if rawget(vim, "lsp") then
					for _, client in ipairs(vim.lsp.get_clients()) do
						if client.attached_buffers then
							return (vim.o.columns > 100 and "  " .. client.name .. " ") or "   LSP "
						end
					end
				end

				return ""
			end,
			recording = function()
				local r = vim.fn.reg_recording()

				if string.len(r) > 0 then
					return ' @ ' .. r
				end
				-- r = vim.fn.reg_recorded()
				--
				-- if string.len(r) > 0 then
				-- 	return '%#StText# @ ' .. r
				-- end
			end,
			cursor = function()
				return gen_block("", "%L/%l/%c", "%#St_Pos_sep#", "%#St_Pos_bg#", "%#St_Pos_txt#")
				-- return "%#St_Pos_sep#"..
			end,
			path = function()
				local path = vim.api.nvim_buf_get_name(0)

				if path:find "oil" then
					return
				end
				local dir = (path == "" and "Empty ") or path:match "([^/\\]+)[/\\]([^/\\]+)$"
				if dir then
					return gen_block(require('nvchad.icons.lspkind').Folder, dir, "%#St_Pos_sep#", "%#St_Pos_bg#",
						"%#St_Pos_txt#")
				end
			end,
			-- modified = function()
			-- 	local is_modified = vim.bo[0].modified
			-- 	return is_modified and ' ⚪' or ''
			-- end,

			file = function()
				local is_modified = vim.bo[0].modified
				local modified = ""
				if is_modified then
					modified = ""
				end
				local x = utils.file()
				if x then
					return gen_block(x[1], x[2] .. " " .. modified, "%#St_file_sep#", "%#St_file_bg#", "%#St_file_txt#")
				end
			end,
		},

	},
	cmp = {
		icons = true,
		lspkind_text = true,
		style = "default", -- default/flat_light/flat_dark/atom/atom_colored
		format_colors = {
			tailwind = true
		}
	},
	telescope = { style = "bordered" },
}
M.base46 = {
	theme = "catppuccin",
	hl_add = {

		CurSearch = { bg = "#89bfad", fg = "black" },
	},
	hl_override = {
		["@comment"] = { italic = true },
		Search = { bg = "red", fg = "black" },
		-- Cursorline = { bg = "#252434" },
		GitSignsCurrentLineBlame = { group = "@comment", },
	},
}
return M
