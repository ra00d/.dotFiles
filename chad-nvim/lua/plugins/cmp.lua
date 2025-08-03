return {
	-- Autocompletion
	"hrsh7th/nvim-cmp",
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",

		-- Adds LSP completion capabilities
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-calc",
		"hrsh7th/cmp-copilot",
		-- Adds a number of user-friendly snippets
		"rafamadriz/friendly-snippets",
	},

	config = function(_, opts)
		local cmp = require "cmp"
		local luasnip = require "luasnip"
		-- opts.formatting.format = function(entry, item)
		-- 	local f = require('nvchad.cmp').formatting.format(entry, item)
		-- 	f.menu = (item.completed_item.detail or "")
		-- 	return f
		-- end
		opts.mapping = cmp.mapping.preset.insert {
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete {},
			["<C-c>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			},
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}
		local function merge_arrays(t1, t2)
			local result = vim.tbl_extend("force", t1, {}) -- copy t1
			for _, v in ipairs(t2) do
				table.insert(result, v)
			end
			return result
		end

		opts.sources = merge_arrays(opts.sources, {
			{ name = "calc" },

			{ name = "codeium" }
		})
		cmp.setup(opts)
	end,
}
