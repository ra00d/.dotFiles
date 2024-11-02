local options = {

  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- Use a sub-list to run only the first available formatter
    javascript = { "prettierd", "prettier", "biome", stop_after_first = true, lsp_format = "fallback" },
    typescript = { "prettierd", "prettier", "biome", stop_after_first = true, lsp_format = "fallback" },
    javascriptreact = { "prettierd", "prettier", "biome", stop_after_first = true, lsp_format = "fallback" },
    typescriptreact = { "prettierd", "prettier", "biome", stop_after_first = true, lsp_format = "fallback" },
    json = { "prettierd", "prettier", "biome", stop_after_first = true, lsp_format = "fallback" },

    html = { "prettierd", "prettier", stop_after_first = true, lsp_format = "fallback" },
    css = { "prettierd", "prettier", stop_after_first = true, lsp_format = "fallback" },
    yaml = { "prettierd", "prettier", stop_after_first = true, lsp_format = "fallback" },
    graphql = { "prettierd", "prettier", stop_after_first = true, lsp_format = "fallback" },
    markdown = { "prettierd", "prettier", stop_after_first = true, lsp_format = "fallback" },
    --go formatters
    go = { "gofumpt", "gofmt", "golines", stop_after_first = true },
    blade = { "blade-formatter", "blade-formatter" },
    php = { "php_cs_fixer" },

    -- SQL
    sql = { "sql_formatter" },
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

require("conform").setup(options)
