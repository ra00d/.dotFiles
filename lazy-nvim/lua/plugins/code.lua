return {
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    enabled = true,
    -- branch = "develop"
    -- (optional) updates the plugin's dependencies on each update
    build = function()
      vim.cmd.GoInstallDeps()
    end,
    ---@type gopher.Config
    opts = {},
  },
}
