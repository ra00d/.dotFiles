-- EXAMPLE
local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
	params = {
		command = "_typescript.removeUnusedImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
	params = {
		command = "_typescript.addMissingImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end
local servers = {
	html = {
		filetypes = {
			"html",
			"css",
			"scss",
			"javascriptreact",
			"typescriptreact",
			"hbs",
			"handlebars",
			"vue",
		},
	},
	lua_ls = {},
	bashls = {
		filetypes = {
			"sh",
			"zsh",
			"bash",
			"zsh",
			"csh",
			"fish",
			"tcsh",
		},
	},

	cssls = {},
	tailwindcss = {},
	emmet_language_server = {
		filetypes = {
			"html",
			"javascriptreact",
			"typescriptreact",
			"hbs",
			"handlebars",
			"vue",
		},

	},
	astro = {},
	gopls = {
		settings = {
			gopls = {

				completeUnimported = true,
				usePlaceholders = true,
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
				gofumpt = true,
			},
		}
	},
	ts_ls = {
		root_dir = function(fname)
			return require("lspconfig.util").root_pattern("package.json")(fname)
		end,
		init_options = {
			codeActionsOnSave = {
				removeUnusedImports = true
			},
			preferences = {
				completeFunctionsCall = false,
				-- includeInlayParameterNameHints = "all",
				-- includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				-- includeInlayFunctionParameterTypeHints = true,
				-- includeInlayVariableTypeHints = false,
				-- includeInlayPropertyDeclarationTypeHints = true,
				-- includeInlayFunctionLikeReturnTypeHints = true,
				-- includeInlayEnumMemberValueHints = true,
				-- importModuleSpecifierPreference = 'non-relative'
			},
		},
		commands = {
			OrganizeImports = {
				organize_imports,
				description = "Organize Imports",
			},
		},
	},
	prismals = {

	},
	jsonls = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
				schemaDownload = {
					enable = true,
				},
			},
		},
	}
	,
	yamlls = {},
	csharp_ls = {},
	helm_ls = {}
}

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local function lsp_code_actions()
	local params = vim.lsp.util.make_range_params()
	params.context = {
		diagnostics = vim.lsp.diagnostic.get_line_diagnostics()
	}
	vim.lsp.buf_request(0, 'textDocument/codeAction', params, function(err, result, context)
		if err or not result or vim.tbl_isempty(result)
		then
			require('snacks').notify('No code action available', {
				once = true,
				level = "info"
			})
			return
		end
		local items = {}
		for i, action in ipairs(result) do
			require('snacks').notify(action.title, {
				once = true,
				level = "info"
			})

			items[i] = {
				idx = i,
				title = action.title,
				action = action
			}
		end
		pickers.new({
			layout_config = {

				horizontal = {
					prompt_position = "top",
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.50,
				height = 0.80,

			}

		}, {
			prompt_title = "Code Actions",
			finder = finders.new_table {
				results = items,
				entry_maker = function(item)
					return {
						value = item,
						display = item.title,
						ordinal = item.title,
					}
				end
			},
			sorter = conf.generic_sorter(),
			attach_mappings = function(prompt_bufnr, map)
				local excute_action = function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					if selection.value.action.edit or type(selection.value.action.command) == 'table' then
						-- vim.lsp.util.apply_workspace_edit(selection.value.action.edit, 'utf-8')
						if selection.value.action.command then
							vim.lsp.buf.execute_command(selection.value.action.command)
						end
					else
						vim.lsp.buf.execute_command(selection.value.action)
					end
				end
				map({ 'i', "n" }, '<CR>', excute_action)
				return true
			end

		}):find()
	end)
end
local on_attach = function(_, bufnr)
	local map = vim.keymap.set
	local function opts(desc)
		return { buffer = bufnr, desc = "LSP " .. desc }
	end
	-- map("n", "<space>rn", vim.lsp.buf.rename, opts "[R]e[n]ame")
	-- map("n", "<space>ca", vim.lsp.buf.code_action, opts "[C]ode [A]ction")

	map("n", "gd", require("telescope.builtin").lsp_definitions, opts "[G]oto [D]efinition")
	map("n", "gr", require("telescope.builtin").lsp_references, opts "[G]oto [R]eferences")
	map("n", "gI", require("telescope.builtin").lsp_implementations, opts "[G]oto [I]mplementation")
	map("n", "<space>D", require("telescope.builtin").lsp_type_definitions, opts "Type [D]efinition")
	map("n", "<space>ds", require("telescope.builtin").lsp_document_symbols, opts "[D]ocument [S]ymbols")
	map("n", "<space>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, opts "[W]orkspace [S]ymbols")
	map("n", "<space>ca", lsp_code_actions, opts "[W]orkspace [S]ymbols")


	map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
	map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")
	map("n", "<leader>rn", require "nvchad.lsp.renamer", opts "NvRenamer")

	map({ "n", "v" }, "<leader>ca", lsp_code_actions, opts "Code action")
end
local configs = require "nvchad.configs.lspconfig"

for name, opts in pairs(servers) do
	opts.on_init = configs.on_init
	opts.on_attach = on_attach
	opts.capabilities = configs.capabilities

	require("lspconfig")[name].setup(opts)
end

-- local function hasKey(array, key)
-- 	for _, obj in ipairs(array) do
-- 		-- Check if the current object has the key (even if the value is nil)
-- 		if obj[key] ~= nil then
-- 			return true
-- 		end
-- 	end
-- 	return false
-- end

-- require("mason-lspconfig").setup_handlers {
-- 	-- The first entry (without a key) will be the default handler
-- 	-- and will be called for each installed server that doesn't have
-- 	-- a dedicated handler.
-- 	function(server_name) -- default handler (optional)
-- 		local has_key = hasKey(servers, server_name)
-- 		if not has_key then
-- 			require("lspconfig")[server_name].setup {
-- 				on_init = configs.on_init,
-- 				on_attach = on_attach,
-- 				capabilities = configs.capabilities,
-- 			}
-- 		end
-- 	end,
-- 	-- Next, you can provide a dedicated handler for specific servers.
-- 	-- For example, a handler override for the `rust_analyzer`:
-- 	["rust_analyzer"] = function()
-- 		require("rust-tools").setup {}
-- 	end
-- }


configs.defaults()
