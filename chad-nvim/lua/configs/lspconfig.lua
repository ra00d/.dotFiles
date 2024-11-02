-- EXAMPLE
local on_attach_nvchad = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local on_attach = function(client, bufnr)
  on_attach_nvchad(client, bufnr)
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
  -- nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
  -- nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
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

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })
  -- if client.server_capabilities.inlayHintProvider then
  --   vim.lsp.inlay_hint.enable(bufnr, true)
  -- end
  -- on_attach_nvchad(client, bufnr)
end
local lspconfig = require "lspconfig"
local servers = { "lua_ls", "cssls", "tailwindcss", "emmet_language_server", "astro" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
lspconfig.gopls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  -- cmd = "gopls",
  settings = {

    gopls = {

      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}
-- typescript

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
  params = {
    command = "_typescript.removeUnusedImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
  params = {
    command = "_typescript.addMissingImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "",
  }
  vim.lsp.buf.execute_command(params)
end
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
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
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
}
-- lspconfig.vtsls.setup {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
-- }
lspconfig.html.setup {
  filetypes = {
    "html",
    "css",
    "scss",
    "javascriptreact",
    "typescriptreact",
    "hbs",
    "handlebars",
    "vue",
  },
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
lspconfig.emmet_language_server.setup {
  filetypes = {
    "html",
    "javascriptreact",
    "typescriptreact",
    "hbs",
    "handlebars",
    "vue",
  },
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
require("lspconfig").jsonls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
      schemaDownload = {
        enable = true,
      },
    },
  },
}
require("lspconfig").astro.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
