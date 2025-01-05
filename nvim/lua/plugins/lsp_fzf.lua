-- NOTE: Configuration for lsp, with fzf configuration
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
		"ibhagwan/fzf-lua",
	},
	config = function()
		-- Create autocommands for LSP
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Fzf-Lua mappings for LSP actions
				local fzf = require("fzf-lua")
				map("gd", fzf.lsp_definitions, "[G]oto [D]efinition")
				map("gr", fzf.lsp_references, "[G]oto [R]eferences")
				map("gI", fzf.lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", fzf.lsp_typedefs, "Type [D]efinition")
				map("<leader>ds", fzf.lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", fzf.lsp_workspace_symbols, "[W]orkspace [S]ymbols")

				-- Standard LSP mappings
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- Highlight references and manage inlay hints
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.supports_method("textDocument/documentHighlight") then
					local highlight_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = true })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.clear_references,
					})
				end
				if client and client.supports_method("textDocument/inlayHint") then
					map("<leader>th", function()
						vim.lsp.inlay_hint(event.buf, nil, not vim.lsp.inlay_hint_is_enabled(event.buf))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- Diagnostic signs configuration
		local signs = { Error = "", Warn = "", Hint = "", Info = "" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			float = { border = "rounded" },
		})

		-- Setup capabilities for LSP servers
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		-- Language servers setup
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
						diagnostics = { globals = { "vim" } },
					},
				},
			},
			ts_ls = { -- Use 'tsserver', not 'ts_ls'
				settings = {
					typescript = {
						ts_ls = {
							useSyntaxServer = false,
						},
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayVariableTypeHintsWhenTypeMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
				init_options = {
					maxTsServerMemory = 4096,
					preferIncrementalParsing = true,
				},
			},
			clangd = { -- Adding clangd for C++
				cmd = { "clangd" },
				filetypes = { "c", "cpp", "objc", "objcpp" },
				root_dir = require("lspconfig").util.root_pattern("compile_commands.json", ".git"),
				settings = {
					clangd = {
						completion = { enable = true },
						diagnostics = { enable = true },
						-- Add more clangd-specific settings if needed
					},
				},
			},
		}
		-- Ensure language servers are installed
		require("mason").setup()
		require("mason-tool-installer").setup({ ensure_installed = vim.tbl_keys(servers) })
		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup(
						vim.tbl_deep_extend("force", { capabilities = capabilities }, servers[server_name] or {})
					)
				end,
			},
		})
	end,
}
