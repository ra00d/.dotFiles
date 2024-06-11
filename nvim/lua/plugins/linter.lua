return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local linter = require 'lint'
    linter.linters_by_ft = {
      javascript = { 'biome', 'eslint_d', 'eslint' },
      typescript = { 'biome', 'eslint_d', 'eslint' },
      javascriptreact = { 'eslint_d', 'eslint' },
      typescriptreact = { 'eslint_d', 'eslint' },
      go = { 'golangcilint' },
    }
  end,
}
