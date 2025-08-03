return {
	"Exafunction/windsurf.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	event = "VeryLazy",
	config = function()
		require("codeium").setup({
			-- enable_cmp_source = true,

			key_bindings = {
				-- Accept the current completion.
				accept = "jj",
				-- Accept the next word.
				accept_word = 'jw',
				-- Accept the next line.
				accept_line = 'jl',
				-- Clear the virtual text.
				clear = false,
				-- Cycle to the next completion.
				next = "<M-n>",
				-- Cycle to the previous completion.
				prev = "<M-p>",
			}

		})

		local cmp = require('cmp')
		-- cmp.setup({
		-- 	sources = {
		-- 		{ name = "codeium" },
		-- 		{ name = "calc" }
		-- 	}
		-- })
	end
}
