return {

  "catppuccin/nvim",
  name = "catppuccin",
  priority = 100000,
  -- enabled = false,
  lazy = false,
  config = function()
    vim.cmd.colorscheme("catppuccin")
    require("catppuccin").setup({
      default_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,

        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        indent_blankline = {
          enabled = true,
          scope_color = "text", -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = false,
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    })
  end,
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
