local function get_gitignore_dir()
  -- Try environment variable first
  local env_dir = os.getenv("GITIGNORE_TEMPLATES_DIR")
  if env_dir and env_dir ~= "" then
    return vim.fn.expand(env_dir)
  end

  -- Fallback locations
  local fallback_locations = {
    vim.fn.expand("~/.gitignore"),
    vim.fn.expand("~/.config/gitignore"),
    vim.fn.expand("~/gitignore"),
    vim.fn.expand("~/.dotFiles/gitignore"),
  }

  for _, dir in ipairs(fallback_locations) do
    if vim.fn.isdirectory(dir) == 1 then
      return dir
    end
  end

  return nil
end

local function select_gitignore_telescope()
  local gitignore_dir = get_gitignore_dir()
  if not gitignore_dir then
    vim.notify(
      "Gitignore templates directory not found.\n"
        .. "Set environment variable: export GITIGNORE_TEMPLATES_DIR=/path/to/gitignore\n"
        .. "Or place templates in ~/.gitignore/",
      vim.log.levels.ERROR,
      { title = "Gitignore Templates" }
    )
    return
  end

  -- Check if Telescope is available
  if not pcall(require, "telescope") then
    vim.notify("Telescope.nvim is required for this feature", vim.log.levels.ERROR)
    return
  end

  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local builtin = require("telescope.builtin")

  builtin.find_files({
    prompt_title = "📁 Gitignore Templates",
    cwd = gitignore_dir,
    search_dirs = { ".", "Global" },
    -- find_command = { "find", ".", "-name", "*.gitignore", "-type", "f" },

    -- Format the display of files
    -- path_display = function(_, path)
    --   local display = path:gsub("^./", ""):gsub("%.gitignore$", "")
    --   display = display:gsub("/", " → ")
    --   return display
    -- end,

    attach_mappings = function(prompt_bufnr, map)
      -- Custom action to insert content
      local function insert_gitignore()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        if entry then
          local filepath = entry.path
          local lines = vim.fn.readfile(filepath)

          -- Insert content at cursor position
          vim.api.nvim_put(lines, "l", true, true)

          -- Show notification
          local template_name = filepath:gsub(gitignore_dir .. "/", ""):gsub("%.gitignore$", "")
          vim.notify("Pasted: " .. template_name, vim.log.levels.INFO, { title = "Gitignore" })
        end
      end

      -- Map Enter to insert content
      map("i", "<CR>", insert_gitignore)
      map("n", "<CR>", insert_gitignore)

      -- Preview the gitignore content (optional)
      local function preview_gitignore()
        local entry = action_state.get_selected_entry()
        if entry then
          local lines = vim.fn.readfile(entry.path)
          local preview_lines = {}

          -- Get first 50 lines for preview
          for i = 1, math.min(50, #lines) do
            table.insert(preview_lines, lines[i])
          end

          if #lines > 50 then
            table.insert(preview_lines, "...")
            table.insert(preview_lines, string.format("(%d more lines)", #lines - 50))
          end

          -- Show in a floating window
          local buf = vim.api.nvim_create_buf(false, true)
          local width = math.floor(vim.o.columns * 0.8)
          local height = math.floor(vim.o.lines * 0.8)

          local win = vim.api.nvim_open_win(buf, true, {
            relative = "editor",
            width = width,
            height = height,
            col = math.floor((vim.o.columns - width) / 2),
            row = math.floor((vim.o.lines - height) / 2),
            style = "minimal",
            border = "rounded",
          })

          vim.api.nvim_buf_set_lines(buf, 0, -1, false, preview_lines)
          vim.api.nvim_buf_set_option(buf, "modifiable", false)
          vim.api.nvim_buf_set_option(buf, "filetype", "gitignore")

          -- Close preview with Esc
          vim.keymap.set("n", "<Esc>", function()
            vim.api.nvim_win_close(win, true)
          end, { buffer = buf })
        end
      end

      -- Map Ctrl-p to preview
      map("i", "<C-p>", preview_gitignore)
      map("n", "<C-p>", preview_gitignore)

      return true
    end,

    -- Sort by name
    sorter = require("telescope.sorters").get_fuzzy_file(),
    hidden = true,
    no_ignore = false,
    no_ignore_parent = false,
    file_ignore_patterns = { ".git/", "node_modules/" },
  })
end

-- Create user command
vim.api.nvim_create_user_command("GitignorePaste", select_gitignore_telescope, {
  desc = "Select gitignore template with Telescope",
})

-- Key mapping
vim.keymap.set("n", "<leader>gp", select_gitignore_telescope, {
  desc = "Paste gitignore template (Telescope)",
})
