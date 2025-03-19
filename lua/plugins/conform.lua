return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	init = function()
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function()
				local bufnr = vim.fn.bufnr()
				require("conform").format({ bufnr = bufnr })
			end,
		})
	end,

	config = function()
		require("conform").setup({
			default_format_opts = {
				timeout_ms = 3000,
				async = false, -- not recommended to change
				quiet = false, -- not recommended to change
				lsp_format = "fallback", -- not recommended to change
			},
			formatters_by_ft = {
				-- python = { "isort", "black" },
				lua = { "stylua" },
				sh = { "shfmt" },
				javascript = { "prettier" },
				go = { "gofumpt" },
			},
			formatters = {
				injected = { options = { ignore_errors = true } },
				prettier = {
					prepend_args = { "--tab-width", "4" }, -- Establece la indentación a 4 espacios
				},
			},
		})
	end,
}
