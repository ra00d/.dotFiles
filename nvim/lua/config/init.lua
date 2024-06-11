require 'config.settings'
require 'config.mappings'
require 'config.helpers'
-- require 'snippets-lua'
require 'config.lsp'

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',

      -- timeout = 100,
    }
  end,
})
--
vim.api.nvim_create_user_command(
  'GenSecret',
  [[r !node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"]],
  {
    desc = 'generate secret key using node',
  }
)
