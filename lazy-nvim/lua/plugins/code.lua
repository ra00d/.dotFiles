return {
  {

    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false,
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim.
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = true,
      },
      servers = {
        jsonls = {
          -- lazy-load schemastore when needed
          before_init = function(_, new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
      },
    },
    -- _opts = function()
    --   ---@class PluginLspOpts
    --   -- local ret = {
    --   --   -- options for vim.diagnostic.config()
    --   --   ---@type vim.diagnostic.Opts
    --   --   diagnostics = {
    --   --     underline = true,
    --   --     update_in_insert = false,
    --   --     virtual_text = {
    --   --       spacing = 4,
    --   --       source = "if_many",
    --   --       prefix = "●",
    --   --       -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
    --   --       -- prefix = "icons",
    --   --     },
    --   --     severity_sort = true,
    --   --     signs = {
    --   --       text = {
    --   --         [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
    --   --         [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
    --   --         [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
    --   --         [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
    --   --       },
    --   --     },
    --   --   },
    --   --   -- Enable this to enable the builtin LSP inlay hints on Neovim.
    --   --   -- Be aware that you also will need to properly configure your LSP server to
    --   --   -- provide the inlay hints.
    --   --   inlay_hints = {
    --   --     enabled = false,
    --   --     exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
    --   --   },
    --   --   -- Enable this to enable the builtin LSP code lenses on Neovim.
    --   --   -- Be aware that you also will need to properly configure your LSP server to
    --   --   -- provide the code lenses.
    --   --   codelens = {
    --   --     enabled = true,
    --   --   },
    --   --
    --   --   -- options for vim.lsp.buf.format
    --   --   -- `bufnr` and `filter` is handled by the LazyVim formatter,
    --   --   -- but can be also overridden when specified
    --   --   -- format = {
    --   --   --   formatting_options = nil,
    --   --   --   timeout_ms = nil,
    --   --   -- },
    --   --   -- LSP Server Settings
    --   --   -- Sets the default configuration for an LSP client (or all clients if the special name "*" is used).
    --   --
    --   --   -- you can do any additional lsp server setup here
    --   --   -- return true if you don't want this server to be setup with lspconfig
    --   --   ---@type table<string, fun(server:string, opts: vim.lsp.Config):boolean?>
    --   --   setup = {
    --   --     -- example to setup with typescript.nvim
    --   --     -- tsserver = function(_, opts)
    --   --     --   require("typescript").setup({ server = opts })
    --   --     --   return true
    --   --     -- end,
    --   --     -- Specify * to use this function as a fallback for any server
    --   --     -- ["*"] = function(server, opts) end,
    --   --   },
    --   -- }
    --   -- return ret
    -- end,
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    enabled = true,
    -- branch = "develop"
    -- (optional) updates the plugin's dependencies on each update
    build = function()
      vim.cmd.GoInstallDeps()
    end,
    opts = {},
  },
}
