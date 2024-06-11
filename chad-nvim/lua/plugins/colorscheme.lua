return {

  "catppuccin/nvim",
  name = "catppuccin",
  priority = 10000,
  lazy = false,
  config = function()
    vim.cmd.colorscheme "catppuccin"
  end,
}
