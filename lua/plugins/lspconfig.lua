return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},

		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			local function on_attach(client, bufnr)
				-- Keybindings for LSP features

				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"gD", -- Change to gD for definition
					"<Cmd>rightbelow vsplit<CR><Cmd>lua vim.lsp.buf.definition()<CR>", -- Open definition in a vertical split to the right
					{ noremap = true, silent = true }
				)

				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"gd",
					"<Cmd>lua vim.lsp.buf.hover()<CR>",
					{ noremap = true, silent = true }
				)
			end

			-- Lua Server
			require("lspconfig").lua_ls.setup({
				on_attach = on_attach,
			})

			-- Go Server
			require("lspconfig").gopls.setup({
				on_attach = on_attach,
			})

			-- Python Server
			require("lspconfig").pyright.setup({
				on_attach = on_attach,
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							useLibraryCodeForTypes = true,
						},
					},
				},
			})

			-- TypeScript Server
			require("lspconfig").tsserver.setup({
				capabilities = capabilities,
				filetypes = {
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"html",
				},
				on_attach = on_attach,
			})

			-- HTML Server
			require("lspconfig").html.setup({
				capabilities = capabilities,
				filetypes = { "html" },
				on_attach = on_attach,
			})

			-- CSS Server
			require("lspconfig").cssls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			-- TailwindCSS Server
			require("lspconfig").tailwindcss.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			require("lspconfig").bashls.setup({ capabilities = capabilities })
			require("lspconfig").dockerls.setup({ capabilities = capabilities })
			require("lspconfig").yamlls.setup({ capabilities = capabilities })

			require("lspconfig").emmet_language_server.setup({
				capabilities = capabilities,
				filetypes = { "html", "css", "javascriptreact", "typescriptreact", "vue", "jsx", "tsx" },
				on_attach = on_attach,
			})

			vim.diagnostic.config({
				virtual_text = { prefix = "" },
				signs = false,
				underline = false,
				update_in_insert = false,
				float = {
					border = "single",
					source = "always",
				},
			})
		end,
	},
}
