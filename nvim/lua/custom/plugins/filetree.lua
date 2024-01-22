-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true,
      filesystem = {
        commands = {
          -- open_file = function(state)
          --   local node = state.tree:get_node()
          --   if node and node.type == "file" then
          --     -- local file_path = node:get_id()
          --     -- reuse built-in commands to open and clear filter
          --     local cmds = require("neo-tree.sources.filesystem.commands")
          --     cmds.open(state)
          --     -- cmds.clear_filter(state)
          --     -- reveal the selected file without focusing the tree
          --     -- require("neo-tree.sources.filesystem").navigate(state, state.path, file_path)
          --   end
          -- end
        },
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
          reveal = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false, -- only works on Windows for hidden files/directories
          hide_by_name = {
            ".DS_Store",
            "thumbs.db",
            "dist",
            "node_modules",
          },
          hide_by_pattern = {
            --"*.meta",
            --"*/src/*/tsconfig.json",
          }
        },
        window = { mappings = { ['o'] = "open", } },
      },
      event_handlers = {

        {
          event = "file_opened",
          handler = function( --[[ file_path ]])
            -- auto close
            -- vimc.cmd("Neotree close")
            -- OR
            require("neo-tree.command").execute({ action = "close" })
          end
        },
        -- {
        --   event = 'file_added',
        --   handler = function(file_path)
        --     -- local isDirectory = vim.fn.isdirectory(file_path) == 1
        --     local isFile = vim.fn.filereadable(file_path) == 1
        --     if isFile then
        --       vim.cmd('e ' .. file_path)
        --       -- require("neo-tree.command").execute({ action = "close" })
        --     end
        --   end
        -- },
      },
      components = {
        harpoon_index = function(config, node, state)
          local Marked = require("harpoon.mark")
          local path = node:get_id()
          local succuss, index = pcall(Marked.get_index_of, path)
          if succuss and index and index > 0 then
            return {
              text = string.format("→ h %d", index), -- <-- Add your favorite harpoon like arrow here
              highlight = config.highlight or "NeoTreeDirectoryIcon",
            }
          else
            return {}
          end
        end
      },
      renderers = {
        file = {
          { "harpoon_index" }, --> This is what actually adds the component in where you want it
          { "icon" },
          { "name",         use_git_status_colors = true },
          { "diagnostics" },
          { "git_status",   highlight = "NeoTreeDimText" },
        }
      },
    }
  end,
}
