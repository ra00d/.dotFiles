local options = {

  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- Use a sub-list to run only the first available formatter
    javascript = { { "biome", "prettier" } },
    typescript = { { "biome", "prettier" } },
    javascriptreact = { { "biome", "prettier" } },
    typescriptreact = { { "biome", "prettier" } },
    json = { { "biome", "prettier" } },

    html = { "prettier" },
    css = { "prettier" },
    yaml = { "prettier" },
    graphql = { "prettier" },
    markdown = { "prettier" },
    --go formatters
    go = { { "gofumpt", "gofmt" }, "golines" },
    blade = { "blade-formatter", "blade-formatter" },
    php = { "php_cs_fixer" },

    -- SQL
    sql = { "sql_formatter" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

require("conform").setup(options)
