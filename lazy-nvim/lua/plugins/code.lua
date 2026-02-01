return {
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    enabled = false,
    -- branch = "develop"
    -- (optional) updates the plugin's dependencies on each update
    build = function()
      vim.cmd.GoInstallDeps()
    end,
    ---@module "gopher"
    ---@type gopher.Config
    opts = {},
  },
}
