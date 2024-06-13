require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
local options = { silent = true }
-- Define your mappings in separate tables for each mode
local mappings = {
  n = {
    {
      lhs = "<C-s>",
      rhs = "<cmd>wa!<CR>",
      opts = options,
    },
    {
      lhs = "<leader>e",
      rhs = ":NvimTreeFocus<CR>",
      opts = options,
    },
    {
      lhs = "<C-b>",
      rhs = ":NvimTreeToggle<CR>",
      opts = options,
    },
    {
      lhs = "<Tab>",
      rhs = ":bnext<CR>",
      opts = options,
    },
    -- {
    --   lhs = '<C-w>',
    --   rhs = ':bd <CR>',
    --   opts = options,
    -- },
    {
      lhs = "<leader>x",
      rhs = ":bd <CR>",
      opts = options,
    },
    {
      lhs = "<S-Tab>",
      rhs = ":bprev<CR>",
      opts = options,
    },
    {
      lhs = "<C-q>",
      rhs = ":xa<CR>",
      opts = options,
    },
    -- TELESCOPE MAPPINGS
    {
      lhs = "<leader>ff",
      rhs = ":Telescope find_files<CR>",
      opts = options,
    },
    {
      lhs = "<leader>fw",
      rhs = ":Telescope live_grep<CR>",
      opts = options,
    },
    {
      lhs = "<leader>fb",
      rhs = ":Telescope buffers<CR>",
      opts = options,
    },
    -- harpoon mappings
    {
      lhs = "<leader>a",
      rhs = ":lua require('harpoon.mark').add_file()<CR>",
      opts = options,
    },
    -- DBUI MAPPINGS
    {
      lhs = "<leader>tdb",
      rhs = ":DBUIToggle<CR>",
      opts = options,
    },
  },
  i = {
    { lhs = "<C-s>", rhs = "<ESC>:wa!<CR>", opts = options },
    {
      lhs = "<C-q>",
      rhs = ":qa<CR>",
      opts = { desc = "quite all", silent = true },
    },
    {
      lhs = "<C-x>",
      rhs = function()
        local ls = require "luasnip"
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end,
    },
  },
}

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR }
end, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR }
end, { desc = "Go to next diagnostic message" })

vim.keymap.set("n", "[e", vim.diagnostic.goto_next, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]e", vim.diagnostic.goto_prev, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- to disable changing the registers
-- vim.keymap.set({ 'n', 'v' }, 'd', [["d]])
-- delete without copying to clipboard
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
-- change without copying to clipboard
vim.keymap.set({ "n", "v" }, "c", [["_c]])
-- delete without copying to clipboard
vim.keymap.set({ "n", "v" }, "x", [["_x]])
-- paste without clearing the clipboard
vim.keymap.set({ "n", "v" }, "p", [["*p]])
-- paste from system clipboard
vim.keymap.set({ "n", "v" }, "<leader>p", [["0p]])

vim.keymap.set({ "n", "v" }, "<leader>rc", ":silent so ~/.dotFiles/nvim/lua/init.lua<CR>", {
  desc = "reload nvim configuration",
})
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
local nmap = function(keys, func, desc)
  if desc then
    desc = "LSP: " .. desc
  end

  vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
end

nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

-- See `:help K` for why this keymap
nmap("K", vim.lsp.buf.hover, "Hover Documentation")
nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

-- Lesser used LSP functionality
nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
nmap("<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, "[W]orkspace [L]ist Folders")

-- Call the setup function to load the mappings
setup_mappings()
