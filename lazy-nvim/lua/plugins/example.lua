return {
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
        file_ignore_patterns = {
          "node_modules",
          ".git",
          "dist",
          "build",
          "__pycache__",
          "%.lock",
          "venv",
          "vinore",
          "test/*/**.spec.*",
          "*/**.spec.*",
        },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
  -- the opts function can also be used to change the default opts:
}
