return {
  {
    "rose-pine/neovim",
    -- config = function()
    --   vim.cmd.colorscheme("rose-pine")
    -- end
  },
  "rafi/awesome-vim-colorschemes",
  "chriskempson/base16-vim",
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end
  }

}
