vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = { only = { "source.organizeImports" } }
		-- buf_request_sync defaults to a 1000ms timeout. Depending on your
		-- machine and codebase, you may want longer. Add an additional
		-- argument after params if you find that you have to write the file
		-- twice for changes to be saved.
		-- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				end
			end
		end
		vim.lsp.buf.format({ async = false })
	end
})
vim.keymap.set("n", "<leader>fm", "<cmd>silent !golines -w %:p --no-chain-split-dots -m 50 -t 4<cr>", { silent = true })
local function GetNode()
	local ts = require("nvim-treesitter.ts_utils")
	local winnr = vim.api.nvim_get_current_win()
	local bufnr = vim.api.nvim_get_current_buf()
	local node = ts.get_node_at_cursor(winnr)
	if node ~= nil then
		local nt = ""
		while node ~= nil do
			nt = node:type()
			if nt == 'field_declaration_list' then
				for child, _ in node:iter_children() do
					if (child:type() ~= "field_declaration") then
						goto continue
					end
					local start_row, _, end_row, end_col = vim.treesitter.get_node_range(child)
					local content = vim.treesitter.get_node_text(child, bufnr)

					local field_name = content:match("%S+"):sub(1, 1):lower() .. content:match("%S+"):sub(2)
					local replacement = [[`json:"]] .. field_name .. [["`]]
					vim.api.nvim_buf_set_text(bufnr, start_row, end_col, end_row, end_col,
						{ replacement })
					::continue::
				end
			end
			if nt == 'struct_type' then
				break
			end
			node = node:parent()
		end
	end
end

vim.api.nvim_create_user_command("GetNode", function()
	GetNode()
end, {})
