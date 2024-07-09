vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
-- vim.loop.os_uname = function()
--   return {
--     sysname = "Linux",
--     machine = "x86_64",
--     release = " Ubuntu 22.04.2 LTS",
--     version = "#1 SMP Thu Jan 11 04:09:03 UTC 2024",
--   }
-- end
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"
-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")
dofile(vim.g.base46_cache .. "nvimtree")
require "nvchad.autocmds"

-- vim.schedule(function()
-- require "mappings"
-- require "options"
require "autocmd"
require "mappings"
require "commands"
-- require "configs.lspconfig"
-- end)
