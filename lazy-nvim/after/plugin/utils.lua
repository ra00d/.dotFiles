local utils_path = vim.fn.stdpath("config") .. "/lua/utils/"
for _, file in ipairs(vim.fn.readdir(utils_path)) do
  if file:sub(-4) == ".lua" then
    local module_name = "utils." .. file:sub(1, -5)
    pcall(require, module_name)
  end
end
