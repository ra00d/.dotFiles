-- local function getSyntaxNodeType()
--   local cursor = vim.fn.getpos('.')
--   local row, col = cursor[2], cursor[3]
--   print(row, col)
--   -- Get the root of the syntax tree for the current buffer
--   local root = vim.treesitter.get_parser(0):parse()[1]:root()
--
--   -- Find the syntax node under the cursor position
--   local node = root:named_descendant_for_range(row, col, row, col + 1)
--
--   if node then
--     -- Get the node type
--     local node_type = node:type()
--
--     -- Print the node type
--     print('Node Type:', node_type)
--   else
--     print('No syntax node found under the cursor.')
--   end
-- end
-- vim.api.nvim_create_user_command("GetNode", function()
--   getSyntaxNodeType()
-- end, {})
vim.loop.os_uname = function()
  return {
    sysname = 'Linux',
    machine = 'x86_64',
    release = ' Ubuntu 22.04.2 LTS',
    version = '#1 SMP Thu Jan 11 04:09:03 UTC 2024',
  }
end
