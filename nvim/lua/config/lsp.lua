local lspconfig = require 'lspconfig'
local util = require 'lspconfig.util'

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local function organize_imports()
  local params = {
    command = '_typescript.organizeImports',
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = '',
  }
  vim.lsp.buf.execute_command(params)
  params = {
    command = '_typescript.removeUnusedImports',
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = '',
  }
  vim.lsp.buf.execute_command(params)
  params = {
    command = '_typescript.addMissingImports',
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = '',
  }
  vim.lsp.buf.execute_command(params)
end
lspconfig.tsserver.setup {
  root_dir = util.root_pattern(
    'package.json',
    'tsconfig.json',
    'jsconfig.json',
    '.git'
  ),

  init_options = {
    -- codeActionsOnSave = {
    --   removeUnusedImports = true
    -- },
    preferences = {
      completeFunctionsCall = false,
      -- includeInlayParameterNameHints = "all",
      -- includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      -- includeInlayFunctionParameterTypeHints = true,
      -- includeInlayVariableTypeHints = false,
      -- includeInlayPropertyDeclarationTypeHints = true,
      -- includeInlayFunctionLikeReturnTypeHints = true,
      -- includeInlayEnumMemberValueHints = true,
      -- importModuleSpecifierPreference = 'non-relative'
    },
  },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.notify(
      'workspace/didChangeConfiguration',
      { settings = client.config.settings }
    )
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
    -- if client.server_capabilities.inlayHintProvider then
    --   vim.lsp.inlay_hint.enable(bufnr, true)
    -- end
  end,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = 'Organize Imports',
    },
  },
}
require('lspconfig').jsonls.setup {
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
      schemaDownload = {
        enable = true,
      },
    },
  },
}
lspconfig.tailwindcss.setup {
  filetypes = {
    'html',
    'css',
    'scss',
    'javascriptreact',
    'typescriptreact',
    'hbs',
    'vue',
  },
  capabilities = capabilities,
}
