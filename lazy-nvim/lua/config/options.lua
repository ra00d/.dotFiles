-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- AI Options
vim.g.ai_cmp = true
vim.opt.winborder = "rounded"

vim.g.lazyvim_picker = "telescope"
vim.opt.formatoptions:remove({ "o" })
