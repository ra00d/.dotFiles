local options = { silent = true, noremap = true }
-- Define your mappings in separate tables for each mode
local mappings = {
  n = {
    {
      lhs = ';',
      rhs = ':',
      opts = options,
    },
    {
      lhs = '<C-s>',
      rhs = '<ESC>:wa!<CR>',
      opts = options,
    },
    {
      lhs = '<leader>e',
      rhs = ':Neotree focus  reveal=true<CR>',
      opts = options,
    },
    {
      lhs = '<C-b>',
      rhs = ':Neotree toggle reveal=true<CR>',
      opts = options,
    },
    {
      lhs = '<Tab>',
      rhs = ':bnext<CR>',
      opts = options,
    },
    -- {
    --   lhs = '<C-w>',
    --   rhs = ':bd <CR>',
    --   opts = options,
    -- },
    {
      lhs = '<leader>x',
      rhs = ':bd <CR>',
      opts = options,
    },
    {
      lhs = '<S-Tab>',
      rhs = ':bprev<CR>',
      opts = options,
    },
    {
      lhs = '<C-q>',
      rhs = ':xa<CR>',
      opts = options,
    },
    -- TELESCOPE MAPPINGS
    {
      lhs = '<leader>ff',
      rhs = ':Telescope find_files<CR>',
      opts = options,
    },
    {
      lhs = '<leader>fw',
      rhs = ':Telescope live_grep<CR>',
      opts = options,
    },
    {
      lhs = '<leader>fb',
      rhs = ':Telescope buffers<CR>',
      opts = options,
    },
    -- harpoon mappings
    {
      lhs = '<leader>a',
      rhs = ":lua require('harpoon.mark').add_file()<CR>",
      opts = options,
    },
    -- DBUI MAPPINGS
    {
      lhs = '<leader>tdb',
      rhs = ':DBUIToggle<CR>',
      opts = options,
    },
  },
  i = {
    { lhs = '<C-s>', rhs = '<ESC>:w!<CR>', opts = options },
    {
      lhs = '<C-q>',
      rhs = ':qa<CR>',
      opts = { desc = 'quite all', silent = true },
    },
    {
      lhs = '<C-x>',
      rhs = function()
        local ls = require 'luasnip'
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end,
    },
  },
}
-- to disable changing the registers
-- vim.keymap.set({ 'n', 'v' }, 'd', [["d]])
-- delete without copying to clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])
-- change without copying to clipboard
vim.keymap.set({ 'n', 'v' }, 'c', [["_c]])
-- delete without copying to clipboard
vim.keymap.set({ 'n', 'v' }, 'x', [["_x]])
-- paste without clearing the clipboard
vim.keymap.set({ 'n', 'v' }, 'p', [["*p]])
-- paste from system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>p', [["0p]])

vim.keymap.set(
  { 'n', 'v' },
  '<leader>rc',
  ':silent so ~/.dotFiles/nvim/lua/init.lua<CR>',
  {
    desc = 'reload nvim configuration',
  }
)
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

-- Call the setup function to load the mappings
setup_mappings()
