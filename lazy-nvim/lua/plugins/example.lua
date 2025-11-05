-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {

  -- { import = "lazyvim.plugins.extras.lang.typescript" },
  -- { import = "lazyvim.plugins.extras.ui.mini-starter" },
  -- { import = "lazyvim.plugins.extras.lang.json" },
  -- Configure LazyVim to load gruvbox
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "gruvbox",
  --   },
  -- },
  -- override nvim-cmp and add cmp-emoji
  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
file_ignore_patterns={
    "node_modules",
    ".git",
    "dist",
    "build",
    "__pycache__",
    "%.lock",
    "venv",
    ".venv",
    "vinore",
    "test/*/**.spec.*",
    "*/**.spec.*",
  },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
 },
  --
  -- add pyright to lspconfig
  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    keys={
      {'gd',false},
      {'gr',false}
    },
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          local function opts(desc)
            return { buffer = 0, desc = "LSP " .. desc }
          end

          local map=vim.keymap.set

          map("n", "gd", require("telescope.builtin").lsp_definitions, opts("[G]oto [D]efinition"))
          map("n", "gr", require("telescope.builtin").lsp_references, opts("[G]oto [R]eferences"))
          map("n", "gI", require("telescope.builtin").lsp_implementations, opts("[G]oto [I]mplementation"))
          map("n", "<space>D", require("telescope.builtin").lsp_type_definitions, opts("Type [D]efinition"))
          map("n", "<space>ds", require("telescope.builtin").lsp_document_symbols, opts("[D]ocument [S]ymbols"))
          map("n", "<space>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, opts("[W]orkspace [S]ymbols"))

          map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
          -- stylua: ignore
          -- vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          -- vim.keymap.set("n", "<leader>fm", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          -- vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = function(_, opts)
      local ret = {
        servers = {
          -- tsserver will be automatically installed with mason and loaded with lspconfig
          tsserver = {},
          lua_ls = {},
          dockerls={},
docker_compose_language_service={}
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        setup = {
          -- example to setup with typescript.nvim
          tsserver = function(_, opts)
            require("typescript").setup({ server = opts })
            return true
          end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }
      -- opts.servers.lua_ls = ret.servers.lua_ls
      opts.servers.tsserver = ret.servers.tsserver
      opts.setup.tsserver = ret.setup.tsserver
      return opts
    end,
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          local line_count = vim.api.nvim_buf_line_count(0)
          return " " .. line_count
        end,
      })
      opts.options.section_separators = ''
      opts.options.component_separators = ''
      return opts
    end,
  },
  --
  -- -- or you can return new options to override all the defaults
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   opts = function()
  --     return {
  --       --[[add your custom lualine config here]]
  --     }
  --   end,
  -- },
  --
  -- use mini.starter instead of alpha

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc

  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        -- "shellcheck",
        "shfmt",
        "flake8",
        'lua-language-server'
      },
    },
  },
}
