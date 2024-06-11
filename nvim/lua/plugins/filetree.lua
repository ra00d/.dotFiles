-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]
local default_components = {
  container = {
    enable_character_fade = true,
  },
  indent = {
    indent_size = 1,
    padding = 1, -- extra padding on left hand side
    -- indent guides
    with_markers = true,
    indent_marker = '│',
    last_indent_marker = '└',
    highlight = 'NeoTreeIndentMarker',
    -- expander config, needed for nesting files
    with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
    expander_collapsed = '',
    expander_expanded = '',
    expander_highlight = 'NeoTreeExpander',
  },
  icon = {
    folder_closed = '',
    folder_open = '',
    folder_empty = '󰜌',
    -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
    -- then these will never be used.
    default = '*',
    highlight = 'NeoTreeFileIcon',
  },
  modified = {
    indent = 1,
    symbol = '●',
    highlight = 'NeoTreeModified',
  },
  name = {
    indent = 1,
    trailing_slash = false,
    use_git_status_colors = false,
    highlight = 'NeoTreeFileName',
  },
  git_status = {
    enabled = false,
    indent = 1,
    symbols = {
      -- Change type
      added = ' ', -- or "✚", but this is redundant info if you use git_status_colors on the name
      modified = '󰝤 ', -- or "", but this is redundant info if you use git_status_colors on the name
      deleted = ' ', -- this can only be used in the git_status source
      renamed = '󰁕', -- this can only be used in the git_status source
      -- Status type
      untracked = '',
      ignored = '',
      unstaged = '󰄱',
      staged = '',
      conflict = '',
    },
    highlights = {
      conflict = {
        fg = 'green',
      },
    },
  },
  -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
  file_size = {
    enabled = false,
    required_width = 50, -- min width of window required to show this column
  },
  type = {
    enabled = false,
    required_width = 122, -- min width of window required to show this column
  },
  last_modified = {
    enabled = false,
    required_width = 88, -- min width of window required to show this column
  },
  created = {
    enabled = false,
    required_width = 110, -- min width of window required to show this column
  },
  symlink_target = {
    enabled = false,
  },
}
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = true,
      window = {
        position = 'left',
      },
      filesystem = {
        commands = {
          open_file = function(state)
            local node = state.tree:get_node()
            if node and node.type == 'file' then
              -- local file_path = node:get_id()
              -- reuse built-in commands to open and clear filter
              local cmds = require 'neo-tree.sources.filesystem.commands'
              cmds.open(state)
              -- cmds.clear_filter(state)
              -- reveal the selected file without focusing the tree
              -- require("neo-tree.sources.filesystem").navigate(state, state.path, file_path)
            end
          end,
        },
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
          reveal = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false, -- only works on Windows for hidden files/directories
          hide_by_name = {
            '.DS_Store',
            'thumbs.db',
            'dist',
            'node_modules',
          },
          hide_by_pattern = {
            --"*.meta",
            --"*/src/*/tsconfig.json",
          },
        },
        window = { mappings = { ['o'] = 'open' }, width = '20%' },
        components = {
          harpoon_index = function(config, node, _)
            local harpoon_list = require('harpoon').get_mark_config().marks
            local path = node:get_id()
            local harpoon_key = vim.uv.cwd()

            for i, item in ipairs(harpoon_list) do
              local value = item.filename
              if string.sub(item.filename, 1, 1) ~= '/' then
                value = harpoon_key .. '/' .. item.filename
              end

              if value == path then
                vim.print(path)
                return {
                  text = string.format(' ⥤ %d', i), -- <-- Add your favorite harpoon like arrow here
                  highlight = config.highlight or 'NeoTreeDirectoryIcon',
                }
              end
            end
            return {}
          end,
        },
        renderers = {
          file = {
            { 'icon' },
            { 'name', use_git_status_colors = true },
            { 'diagnostics' },
            { 'git_status', highlight = 'NeoTreeDimText' },
          },
        },
      },

      event_handlers = {
        {
          event = 'neo_tree_popup_input_ready',
          ---@param args { bufnr: integer, winid: integer }
          handler = function(args)
            vim.cmd 'stopinsert'
            vim.keymap.set(
              'i',
              '<esc>',
              vim.cmd.stopinsert,
              { noremap = true, buffer = args.bufnr }
            )
          end,
        },
        {
          event = 'file_opened',
          handler = function( --[[ file_path ]])
            -- auto close
            -- vimc.cmd("Neotree close")
            -- OR
            require('neo-tree.command').execute { action = 'close' }
          end,
        },
        {
          event = 'file_added',
          handler = function(file_path)
            -- print(file_path)
            -- require("neo-tree.command").execute({ action = "close" })
            local state =
              require('neo-tree.sources.manager').get_state_for_window()
            local isFile = vim.fn.filereadable(file_path) == 1
            if isFile then
              vim.cmd('e ' .. file_path)
            end
            -- require('neo-tree.sources.common.commands').close_window(state)
            -- vim.cmd("Neotree close")
          end,
          -- command = 'open_file',
          -- handler = "open_file"
        },
      },

      default_component_configs = default_components,
    }
  end,
}
