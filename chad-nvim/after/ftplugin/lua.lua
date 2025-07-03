vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

-- local cmp = require('cmp')
-- require('cmp').setup {
-- 	formatting = {
-- 		format = function(entry, vim_item)
-- 			local s = require('snacks.notify')
-- 			s.info(entry.completion_item.detail)
-- 			return vim_item
-- 		end,
-- 		expandable_indicator = true,
-- 		fields = { "abbr", "kind", "menu" }
-- 	},
-- 	sources = {
-- 		{ name = "nvim_lsp" }
-- 	}
-- }
