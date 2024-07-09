-- vim.keymap.set({ "n" }, "<leader>fm", "<cmd>silent !biome format --write %:p<CR>")
vim.keymap.set({ "n" }, "<leader>fm", "<cmd>silent OrganizeImports<CR>")
local set = vim.opt_local

set.shiftwidth = 2
