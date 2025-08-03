-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function opts(desc)
  return { buffer = 0, desc = "LSP " .. desc }
end

local map = vim.keymap.set
map("n", "<C-q>", "<cmd> wq <CR>", { desc = "Quit vim" })
map("n", "<C-e>", function()
  require("snacks").explorer.open({
    auto_close = true,
    -- focus = true,
    jump = {
      close = true,
    },
    hidden = true,
    ignored = true,
  })
end, {
  desc = "Toggle file tree",
})
map("n", "<leader>e", function()
  require("snacks").explorer.open({
    auto_close = true,
    -- focus = true,
    jump = {
      close = true,
    },
    hidden = true,
    ignored = true,
    env = { ".env" },
  })
end, { desc = "Focus file tree" })

map("n", "<space>x", "<cmd>bd<CR>", {
  desc = "Close current buffer",
})

map("n", ";", ":", {
  desc = "Enter command mode",
})

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
local options = { silent = true }
-- Define your mappings in separate tables for each mode
local mappings = {
  n = {
    { lhs = "<C-s>", rhs = "<ESC>:silent w!<CR>", opts = { silent = true, desc = "save file" } },
    -- {
    --   lhs = "<space>e",
    --   rhs = function()
    --     local oil = require("oil")
    --     oil.toggle_float()
    --     -- local MiniFiles = require('mini.files')
    --     -- MiniFiles.open(vim.fn.expand("%p"))
    --   end,
    --   opts = options,
    -- },
    -- {
    --   lhs = "<C-b>",
    --   rhs = "<cmd>NvimTreeToggle<CR>",
    --   opts = options,
    -- },
    {
      lhs = "<Tab>",
      rhs = "<cmd>bnext<CR>",
      opts = options,
    },
    -- GIT MAPPINGS
    {
      lhs = "bl",
      rhs = ":Gitsigns toggle_current_line_blame<CR>",
      opts = options,
    },
    -- jump to next hunk
    {
      lhs = "[n",
      rhs = ":Gitsigns next_hunk<CR>",
      opts = options,
    },
    -- jump to previous hunk
    {
      lhs = "[p",
      rhs = ":Gitsigns prev_hunk<CR>",
      opts = options,
    },
    -- {
    --   lhs = '<C-w>',
    --   rhs = ':bd <CR>',
    --   opts = options,
    -- },
    {
      lhs = "<space>x",
      rhs = "<cmd>bd <CR>",
      opts = options,
    },
    {
      lhs = "<S-Tab>",
      rhs = "<cmd>bprev<CR>",
      opts = options,
    },
    {
      lhs = "<C-q>",
      rhs = "<cmd>xa<CR>",
      opts = options,
    },
    -- TELESCOPE MAPPINGS
    {
      lhs = "<space>ff",
      rhs = "<cmd>Telescope files<CR>",
      opts = options,
    },
    {
      lhs = "<C-p>",
      rhs = "<cmd>Telescope files<CR>",
      opts = options,
    },
    {
      lhs = "<space>fw",
      rhs = "<cmd>Telescope live_grep<CR>",
      opts = options,
    },
    {
      lhs = "<space>fb",
      rhs = "<cmd>Telescope buffers initial_mode=normal sort=lastused sort=mru<CR>",
      opts = options,
    },
    {
      lhs = "<space><space>",
      rhs = "<cmd>Telescope buffers initial_mode=normal sort=lastused sort=mru<CR>",
      opts = options,
    },
    {
      lhs = "<space>fr",
      rhs = "<cmd>Telescope resume initial_mode=normal sort=lastused sort=mru<CR>",
      opts = options,
    },

    -- harpoon mappings
    {
      lhs = "<space>a",
      rhs = "<cmd>lua require('harpoon.mark').add_file()<CR>",
      opts = options,
    },
    -- DBUI MAPPINGS
    {
      lhs = "<space>tdb",
      rhs = "<cmd>DBUIToggle<CR>",
      opts = options,
    },
    -- HOP
    {
      lhs = "<space>hw",
      rhs = "<cmd>HopWord<CR>",
      opts = {
        desc = "jump next word",
        silent = true,
      },
    },

    {
      lhs = "<space>hc",
      rhs = "<cmd>HopChar1<CR>",
      opts = {
        desc = "jump  char",
        silent = true,
      },
    },
    {
      lhs = "<space>hl",
      rhs = "<cmd>HopLine<CR>",
      opts = {
        desc = "jump  line",
        silent = true,
      },
    },
    {
      lhs = "<space>dn",
      rhs = "<cmd>NoiceDismiss<CR>",
      opts = {
        silent = true,
        desc = "Dismiss Notification messages",
      },
    },
  },
  i = {
    { lhs = "<C-s>", rhs = "<ESC>:silent w!<CR><ESC>", opts = { silent = true, desc = "save file" } },
    {
      lhs = "<C-q>",
      rhs = ":qa<CR>",
      opts = { desc = "quite all", silent = true },
    },
    {
      lhs = "<C-x>",
      rhs = function()
        local ls = require("luasnip")
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end,
    },
    {
      lhs = "<Tab>",
      rhs = function()
        local cmp = require("blink-cmp")
        return cmp.is_menu_visible() and cmp.select_next({}) or "<Tab>"
      end,
      opts = {
        expr = true,
      },
    },
    {
      lhs = "<S-Tab>",
      rhs = function()
        local cmp = require("blink-cmp")
        return cmp.is_menu_visible() and cmp.select_prev({}) or "<S-Tab>"
      end,
      opts = {
        expr = true,
      },
    },
  },
}

vim.keymap.set("n", "[d", function()
  vim.diagnostic.get_prev({ severity = {
    min = vim.diagnostic.severity.HINT,
  } })
end, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.get_next({
    severity = {
      min = vim.diagnostic.severity.HINT,
    },
  })
end, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "[e", function()
  vim.diagnostic.get_next({
    severity = {

      min = vim.diagnostic.severity.ERROR,
    },
  })
end, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]e", function()
  vim.diagnostic.get_prev({ severity = { min = vim.diagnostic.severity.ERROR } })
end, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<space>k", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "gh", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

-- to disable changing the registers
-- vim.keymap.set({ "n", "v" }, "d", [["0d]], { noremap = true })
-- delete without copying to clipboard
vim.keymap.set({ "n", "v" }, "<space>d", [["_d]], { noremap = true })
-- change without copying to clipboard
vim.keymap.set({ "n", "v" }, "c", [["_c]], { noremap = true })
-- map({ "n", "v" }, "ciw", [["_ciw]])
-- delete without copying to clipboard
map({ "n", "v" }, "x", [["_x]])
-- Function to set mappings for a given mode
local function set_mode_mappings(mode, mode_mappings)
  for _, mapping in ipairs(mode_mappings) do
    vim.keymap.set(mode, mapping.lhs, mapping.rhs, mapping.opts or {})
  end
end
-- Example of setting mappings for different modes
local function setup_mappings()
  for mode, mode_mappings in pairs(mappings) do
    set_mode_mappings(mode, mode_mappings)
  end
end

-- local nmap = function(keys, func, desc)
-- 	if desc then
-- 		desc = "LSP: " .. desc
-- 	end
--
-- 	vim.keymap.set("n", keys, func, { desc = desc })
-- end

-- See `:help K` for why this keymap
-- nmap("K", vim.lsp.buf.hover, "Hover Documentation")

-- Lesser used LSP functionality
-- Call the setup function to load the mappings
setup_mappings()
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

map("n", "gd", require("telescope.builtin").lsp_definitions, opts("[G]oto [D]efinition"))
map("n", "gr", require("telescope.builtin").lsp_references, opts("[G]oto [R]eferences"))
map("n", "gI", require("telescope.builtin").lsp_implementations, opts("[G]oto [I]mplementation"))
map("n", "<space>D", require("telescope.builtin").lsp_type_definitions, opts("Type [D]efinition"))
map("n", "<space>ds", require("telescope.builtin").lsp_document_symbols, opts("[D]ocument [S]ymbols"))
map("n", "<space>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, opts("[W]orkspace [S]ymbols"))

map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
