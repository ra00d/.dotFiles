-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

local M = {}
M.ui = {
  theme = "catppuccin",

  hl_override = {
    ["@comment"] = { italic = true },
    CursorLine = { bg = "gray" },
    Cursor = { bg = "gray" },
  },
  -- lsp = {
  --   signature = false,
  -- },
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
        local dir = (path == "" and "Empty ") or path:match "([^/\\]+)[/\\]([^/\\]+)$"
        local utils = require "nvchad.stl.utils"
        local x = utils.file()
        local name = " " .. dir .. "/" .. x[2] .. " "
        return "%#StText# " .. x[1] .. name .. modified
      end,
    },
  },
  lsp = {
    signature = false,
  },
  -- telescope = { style = "bordered" },
}
return M
