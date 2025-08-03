return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      list = {
        selection = { preselect = true, auto_insert = true },
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      menu = {

        draw = {
          treesitter = { "lsp" },
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              -- (optional) use highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
            kind = {
              -- (optional) use highlights from mini.icons
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
        },
      },
    },

    -- experimental signature help support
    -- signature = { enabled = true },

    -- sources = {
    --   -- adding any nvim-cmp sources here will enable them
    --   -- with blink.compat
    --   compat = {},
    --   default = { "lsp", "path", "snippets", "buffer" },
    -- },

    -- cmdline = {
    --   enabled = false,
    -- },

    keymap = {
      ["<C-y>"] = { "select_and_accept" },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    opts = {
      event_handlers = {

        {
          event = "file_open_requested",
          handler = function()
            -- auto close
            -- vim.cmd("Neotree close")
            -- OR
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    },
  },
}
