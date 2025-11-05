require('snippets/snippets-lua')
local loaders = require "luasnip.loaders.from_vscode"
loaders.load {
	paths = {
		vim.fn.stdpath "config" .. "/lua/snippets",
		"~/.local/share/chad-nvim/lazy/friendly-snippets",
	},
}
