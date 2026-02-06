-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
vim.cmd([[
      autocmd User TelescopePreviewerLoaded setlocal number
    ]])

vim.api.nvim_set_hl(0, "TreesitterContext", { fg = "#cdd6f5", bg = "#1e1e2f" })

function GenerateIndexExports()
  -- Check if we're in index.ts
  if vim.fn.expand("%:t") ~= "index.ts" then
    return
  end

  local dir = vim.fn.expand("%:h")
  local exports = {}
  -- Scan directory for .ts files
  for _, file in ipairs(vim.fn.glob(dir .. "/*.ts", false, true)) do
    local name = vim.fn.fnamemodify(file, ":t:r")
    if name ~= "index" then
      table.insert(exports, "export * from './" .. name .. "'")
    end
  end

  -- Sort and insert
  table.sort(exports)
  vim.api.nvim_buf_set_lines(0, 0, 0, false, exports)

  if #exports > 0 then
    print("✅ Generated " .. #exports .. " export statements")
  else
    print("⚠️  No .ts files to export")
  end
end

-- Quick keymap for index.ts only
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "index.ts",
  callback = function()
    vim.keymap.set("n", "<leader>ei", GenerateIndexExports, { buffer = true })
  end,
})

-- disable copilot if limit exceeded
-- Create autocommand for LSP attachment
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name ~= "copilot" then
      return
    end
    vim.cmd([[Copilot disable]])
  end,
})
