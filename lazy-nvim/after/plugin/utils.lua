local utils_path = vim.fn.stdpath("config") .. "/lua/utils/"

-- Find all Lua files recursively
local lua_files = vim.fn.globpath(utils_path, "**/*.lua", false, true)

for _, file in ipairs(lua_files) do
  -- Convert file path to module name
  -- Example: /path/to/lua/utils/db/postgres.lua -> utils.db.postgres
  local module_name = file
    :gsub("^.*/lua/", "") -- Remove path up to /lua/
    :gsub("%.lua$", "") -- Remove .lua extension
    :gsub("/", ".") -- Replace / with .
  pcall(require, module_name)
end
