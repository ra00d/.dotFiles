return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		lazy = false,
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	version = "*",
	-- 	enabled = true,
	-- 	-- lazy = false,
	-- 	dependencies = {
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	config = function()
	-- 		require("nvim-tree").setup {}
	-- 		-- require "configs.filetree"
	-- 	end,
	-- },
	{
		lazy = false,
		"stevearc/conform.nvim",
		config = function()
			require "configs.conform"
		end,
	},
	{
		event = "VeryLazy",
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
			config = function()
				require("ts_context_commentstring").setup {
					enable_autocmd = false,
				}
			end,
		},
		enabled = false,
		opts = {},
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("Comment").setup {
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			}
		end,
	},
	{
		"theprimeagen/harpoon",

		lazy = false,
		config = function()
			local mark = require "harpoon.mark"
			local ui = require "harpoon.ui"
			require("telescope").load_extension "harpoon"
			vim.keymap.set("n", "<leader>a", mark.add_file)
			vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

			vim.keymap.set("n", "<C-h>", function()
				ui.nav_file(1)
			end)
			vim.keymap.set("n", "<C-t>", function()
				ui.nav_file(2)
			end)
			vim.keymap.set("n", "<C-n>", function()
				ui.nav_file(3)
			end)
			vim.keymap.set("n", "<C-s>", function()
				ui.nav_file(4)
			end)
		end,
	},
	{
		"tpope/vim-surround",
		lazy = false,
		enabled = false,
		-- config = true
	},
	{
		"windwp/nvim-autopairs",
		lazy = true,
		enabled = true
	},

	{
		"folke/todo-comments.nvim",

		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{
		"windwp/nvim-ts-autotag",
		ft = { "tsx", "typescriptreact", "javascriptreact" },
		lazy = true,
		config = function()
			vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
				{
					underline = true,
					virtual_text = {
						spacing = 5,
						severity_limit = "Warning",
					},
					update_in_insert = true,
				})
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"Exafunction/codeium.vim",
		event = "VeryLazy",
		enabled = false,
		config = function()
			-- Change '<C-g>' here to any keycode you like.
			vim.keymap.set("i", "jj", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "jc", function()
				return vim.fn["codeium#complete"]()
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-n>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-,>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true, silent = true })
			vim.keymap.set("i", "<c-c>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true, silent = true })
		end,
	},
	{
		"tpope/vim-dadbod",
		"kristijanhusak/vim-dadbod-ui",
		enabled = false,
		{
			"kristijanhusak/vim-dadbod-completion",
			config = function()
				local cmp = require "cmp"
				cmp.setup.filetype({ "sql" }, {
					sources = {
						{ name = "vim-dadbod-completion" },
						{ name = "buffer" },
					},
				})
			end,
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"olexsmir/gopher.nvim",
		ft = { "go" },
		config = function()
			require("gopher").setup {}
		end,
	},

	-- These are some examples, uncomment them if you want to see them work!
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- require("nvchad.configs.lspconfig").defaults()
			require "configs.lspconfig"
		end,
	},
	{
		"b0o/schemastore.nvim",
	},
	--
	{
		"williamboman/mason.nvim",
		dependencies = {

			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			ensure_installed = {
				"lua-language-server",
				"stylua",
				"html-lsp",
				"css-lsp",
				"prettier",
			},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		enabled = false,
		opts = {
			-- indent = { highlight = { "IblChar" }, char = "" },
			-- whitespace = {
			--   highlight = {
			--     "IblChar",
			--   },
			--   remove_blankline_trail = false,
			-- },
			-- scope = { enabled = true },
		},
	},
	{
		"github/copilot.vim",
		enabled = false,
		event = "VeryLazy",
		config = function()
			vim.keymap.set("i", "jj", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false
			})
			vim.g.copilot_no_tab_map = true
		end,
	}
	--
	-- {
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	opts = {
	-- 		ensure_installed = {
	-- 			"vim", "lua", "vimdoc",
	--      "html", "css"
	-- 		},
	-- 	},
	-- },

	, {
	'lewis6991/gitsigns.nvim',
	-- opts = {
	-- 	current_line_blame = true,
	-- },
	config = function()
		local config = require('nvchad.configs.gitsigns')
		config.current_line_blame = true
		require('gitsigns').setup(config)
	end
}
}
