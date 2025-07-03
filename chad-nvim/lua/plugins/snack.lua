local notifierOpts =
---@class snacks.notifier.Config
{
	enabled = false,
	timeout = 3000, -- default timeout in ms
	width = { min = 40, max = 0.4 },
	height = { min = 1, max = 0.6 },
	-- editor margin to keep free. tabline and statusline are taken into account automatically
	margin = { top = 0, right = 1, bottom = 0 },
	padding = true,           -- add 1 cell of left/right padding to the notification window
	sort = { "level", "added" }, -- sort by level and time
	-- minimum log level to display. TRACE is the lowest
	-- all notifications are stored in history
	level = vim.log.levels.TRACE,
	icons = {
		error = " ",
		warn = " ",
		info = " ",
		debug = " ",
		trace = " ",
	},
	keep = function(notif)
		return vim.fn.getcmdpos() > 0
	end,
	style = "compact",
	top_down = true, -- place notifications from top to bottom
	date_format = "%R", -- time format for notifications
	-- format for footer when more lines are available
	-- `%d` is replaced with the number of lines.
	-- only works for styles with a border
	---@type string|boolean
	more_format = " ↓ %d lines ",
	refresh = 50, -- refresh at most every 50ms
}


return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	enabled = true,
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		notifier = notifierOpts,
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		styles = {
			notification = {
				wo = { wrap = true } -- Wrap notifications
			}
		}
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				-- Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
					"<leader>ub")
				Snacks.toggle.inlay_hints():map("<leader>uh")
			end,
		})
	end,
	keys = {
		-- { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
		-- { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
		{ "<leader>n",  function() Snacks.notifier.show_history() end,   desc = "Notification History" },
		{ "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
		{ "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
		{ "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse" },
		{ "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
		{ "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
		{ "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
		{ "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
		{ "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
		-- { "<c-/>",      function() Snacks.terminal() end,                desc = "Toggle Terminal" },
		{ "<c-_>",      function() Snacks.terminal() end,                desc = "which_key_ignore" },
		{ "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",              mode = { "n", "t" } },
		{ "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",              mode = { "n", "t" } },
	},
}
