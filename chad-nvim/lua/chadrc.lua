-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua
--
---@type ChadrcConfig
local M = {}
M.ui = {

  tabufline = {
    enabled = false,
  },
  statusline = {
    theme = "minimal",
    separator_style = "block",
    modules = {
      file = function()
        local is_modified = vim.bo[0].modified
        local modified = " "
        if is_modified then
          modified = " "
        end
        local path = vim.api.nvim_buf_get_name(0)
        if path:find "oil" then
          return
        end
        local utils = require "nvchad.stl.utils"
        local x
        local dir = (path == "" and "Empty ") or path:match "([^/\\]+)[/\\]([^/\\]+)$"
        if dir then
          x = utils.file()
        end
        if x then
          local name = " " .. dir .. "/" .. x[2] .. " "
          return "%#StText# " .. x[1] .. name .. modified
        end
      end,
    },
  },
  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
  },
  telescope = { style = "bordered" },
}
M.base46 = {
  theme = "catppuccin",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}
return M
