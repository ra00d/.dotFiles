-- vim.api.nvim_create_autocmd({ "VimEnter" }, { command = "Oil" })

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch",

      -- timeout = 100,
    }
  end,
})
--
vim.api.nvim_create_user_command(
  "GenSecret",
  [[r !node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"]],
  {
    desc = "generate secret key using node",
  }
)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function(args)
--     require("conform").format { bufnr = args.buf }
--   end,
-- })
