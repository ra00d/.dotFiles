return {
  "windwp/nvim-ts-autotag",
  ft = { "tsx", "typescriptreact", "javascriptreact" },
  config = function()
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      {
        underline = true,
        virtual_text = {
          spacing = 5,
          severity_limit = 'Warning',
        },
        update_in_insert = true,
      }
    )
    require("nvim-ts-autotag").setup()
  end
}
