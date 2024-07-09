return {
  "nvim-telescope/telescope.nvim",
  opts = function()
    local conf = require "nvchad.configs.telescope"

    conf.defaults.layout_config = {
      horizontal = {
        prompt_position = "bottom",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    }
    -- or
    -- table.insert(conf.defaults.mappings.i, your table)

    return conf
  end,
}
