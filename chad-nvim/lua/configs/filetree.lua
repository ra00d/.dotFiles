local options = {
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
}
require("nvim-tree").setup(options)
local api = require "nvim-tree.api"
api.events.subscribe(api.events.Event.FileCreated, function(file)
  vim.cmd("edit " .. file.fname)
end)
