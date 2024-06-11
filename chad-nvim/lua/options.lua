require "nvchad.options"

-- add yours here!

local opt = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.inccommand = "split"
-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10
opt.hlsearch = true
opt.relativenumber = true
opt.colorcolumn = "100"
opt.wrap = true
opt.swapfile = false
opt.termguicolors = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.smartindent = true
opt.incsearch = true
opt.conceallevel = 1
vim.g.mustache_abbreviations = 1

opt.cursorline = true
opt.cursorlineopt = "both"
-- opt.term = "xterm-256color"

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.foldenable = false
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
-- vim.fs.root = function(source, marker)
--   assert(source, "missing required argument: source")
--   assert(marker, "missing required argument: marker")
--
--   local path ---@type string
--   if type(source) == "string" then
--     path = source
--   elseif type(source) == "number" then
--     if vim.bo[source].buftype ~= "" then
--       path = assert(vim.uv.cwd())
--     else
--       path = vim.api.nvim_buf_get_name(source)
--     end
--   else
--     error 'invalid type for argument "source": expected string or buffer number'
--   end
--
--   local paths = vim.fs.find(marker, {
--     upward = true,
--     path = vim.fn.fnamemodify(path, ":p:h"),
--   })
--
--   if #paths == 0 then
--     return nil
--   end
--
--   return vim.fs.dirname(paths[1])
-- end
--
