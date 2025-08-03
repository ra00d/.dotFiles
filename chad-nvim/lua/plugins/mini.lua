local miniFilesOpts = {
	-- Customization of shown content
	content = {
		-- Predicate for which file system entries to show
		filter = nil,
		-- What prefix to show to the left of file system entry
		prefix = nil,
		-- In which order to show file system entries
		sort = nil,
	},

	-- Module mappings created only inside explorer.
	-- Use `''` (empty string) to not create one.
	mappings = {
		close       = 'q',
		go_in       = '<Enter>',
		go_in_plus  = 'l',
		go_out      = 'h',
		go_out_plus = 'H',
		mark_goto   = "'",
		mark_set    = 'm',
		reset       = '<BS>',
		reveal_cwd  = '@',
		show_help   = 'g?',
		synchronize = '=',
		trim_left   = '<',
		trim_right  = '>',
	},

	-- General options
	options = {
		-- Whether to delete permanently or move into module-specific trash
		permanent_delete = true,
		-- Whether to use for editing directories
		use_as_default_explorer = true,
	},

	-- Customization of explorer windows
	windows = {
		-- Maximum number of windows to show side by side
		max_number = math.huge,
		-- Whether to show preview of file/directory under cursor
		preview = false,
		-- Width of focused window
		width_focus = 50,
		-- Width of non-focused window
		width_nofocus = 15,
		-- Width of preview window
		width_preview = 25,
	},
}

return {
	-- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",
	lazy = false,
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("ts_context_commentstring").setup {
				enable_autocmd = false,
			}
		end,
	},

	config = function()
		require("mini.icons").setup()
		-- require("mini.pairs").setup()
		require("mini.indentscope").setup({
			draw = {
				animation = require('mini.indentscope').gen_animation.none()
			}
		})

		require("mini.ai").setup { n_lines = 500 }
		require("mini.surround").setup()
		require('mini.comment').setup({
			options = {
				custom_commentstring = function()
					return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo
						.commentstring
				end,
			},
		})

		--
		-- local MiniFiles = require("mini.files")
		-- MiniFiles.setup(miniFilesOpts)
		-- local show_dotfiles = true
		--
		-- local filter_show = function(fs_entry) return true end
		--
		-- local filter_hide = function(fs_entry)
		-- 	return not vim.startswith(fs_entry.name, '.')
		-- end
		--
		-- local toggle_dotfiles = function()
		-- 	show_dotfiles = not show_dotfiles
		-- 	local new_filter = show_dotfiles and filter_show or filter_hide
		-- 	MiniFiles.refresh({ content = { filter = new_filter } })
		-- end
		--
		-- vim.api.nvim_create_autocmd('User', {
		-- 	pattern = 'MiniFilesBufferCreate',
		-- 	callback = function(args)
		-- 		local buf_id = args.data.buf_id
		-- 		-- Tweak left-hand side of mapping to your liking
		-- 		vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
		-- 	end,
		-- })

		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nside [']quote

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']

		-- Simple and easy statusline.
		--  You could remove this setup call if you don't like it,
		--  and try some other statusline plugin
		-- local statusline = require "mini.statusline"
		-- statusline.setup({
		-- 	-- Content of statusline as functions which return statusline string. See
		-- 	-- `:h statusline` and code of default contents (used instead of `nil`).
		-- 	content = {
		-- 		-- Content for active window
		-- 		active = function()
		-- 			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
		-- 			local git           = MiniStatusline.section_git({ trunc_width = 40 })
		-- 			local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
		-- 			local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 75 })
		-- 			local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
		-- 			local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
		-- 			local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
		-- 			local location      = MiniStatusline.section_location({ trunc_width = 75 })
		-- 			local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })
		--
		-- 			return MiniStatusline.combine_groups({
		-- 				{ hl = mode_hl,                 strings = { mode } },
		-- 				{ hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
		-- 				'%<', -- Mark general truncate point
		-- 				{ hl = 'MiniStatuslineFilename', strings = { filename } },
		-- 				'%=', -- End left alignment
		-- 				{ hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
		-- 				{ hl = mode_hl,                  strings = { search, location } },
		-- 			})
		-- 		end
		-- 		,
		-- 		-- Content for inactive window(s)
		-- 		inactive = nil,
		-- 	},
		--
		-- 	-- Whether to use icons by default
		-- 	use_icons = true,
		--
		-- 	-- Whether to set Vim's settings for statusline (make it always shown)
		-- 	set_vim_settings = true,
		-- })

		-- You can configure sections in the statusline by overriding their
		-- default behavior. For example, here we disable the section for
		-- cursor information because line numbers are already enabled
		---@diagnostic disable-next-line: duplicate-set-field
		-- statusline.section_location = function()
		--   return ""
		-- end

		-- ... and there is more!
		--  Check out: https://github.com/echasnovski/mini.nvim
	end,
}
