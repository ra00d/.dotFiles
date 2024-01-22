-- Define your mappings in separate tables for each mode
local mappings = {
  n = {
    { lhs = '<C-s>',      rhs = '<ESC>:w!<CR>' },
    { lhs = '<leader>e',  rhs = ':Neotree focus  reveal=true<CR>',             opts = { silent = true } },
    { lhs = '<C-b>',      rhs = ':Neotree toggle reveal=true<CR>',             opts = { silent = true } },
    { lhs = '<Tab>',      rhs = ':bnext<CR>' },
    { lhs = '<leader>x',  rhs = ':bd <CR>',                                    opts = {} },
    { lhs = '<S-Tab>',    rhs = ':bprev<CR>' },
    -- TELESCOPE MAPPINGS
    { lhs = '<leader>ff', rhs = ':Telescope find_files<CR>' },
    { lhs = '<leader>fw', rhs = ':Telescope live_grep<CR>' },
    { lhs = '<leader>fb', rhs = ':Telescope buffers<CR>' },
    -- { lhs = '<leader>fb', rhs = ':Telescope find_files<CR>' },
    -- harpoon mappings
    { lhs = '<leader>a',  rhs = ":lua require('harpoon.mark').add_file()<CR>", opts = { silent = true } },
    -- LuaSnip mappings
    -- increament and decreament
    -- {
    --   lhs = '<C-A>',
    --   rhs = ":silent norm <C-X><CR>",
    --   opts = {
    --     silent = true,
    --     desc = "decreament mapping"
    --   }
    -- },
    -- {
    --   lhs = "<C-x>",
    --   rhs = function()
    --     local ls = require('luasnip')
    --     if ls.expand_or_jumpable() then
    --       ls.expand_or_jump()
    --     end
    --   end
    -- },
    -- DBUI MAPPINGS
    {
      lhs = "<leader>tdb",
      rhs = ":DBUIToggle<CR>",
      opts = {
        silent = true,
      }

    }

  },
  i = {
    { lhs = '<C-s>', rhs = '<ESC>:w!<CR>', opts = { silent = true } },
    -- { lhs = '<C-q>', rhs = ':q<CR>' },
    {
      lhs = "<C-x>",
      rhs = function()
        local ls = require('luasnip')
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end
    }

  },

}
-- to disable changing the registers
vim.keymap.set({ "n", "v" }, "d", [["0d]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set({ "n", "v" }, "c", [["_c]])
vim.keymap.set({ "n", "v" }, "x", [["_x]])
vim.keymap.set({ "n", "v" }, "p", [["0p]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["*p]])
vim.keymap.set({ "n", "v" }, "<leader>rc", ":silent so ~/.dotFiles/nvim/lua/custom/init.lua<CR>", {
  desc =
  "reload nvim configuration"
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

-- Call the setup function to load the mappings
setup_mappings()
