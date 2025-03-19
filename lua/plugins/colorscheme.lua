return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,

	config = function()
		require("catppuccin").setup({
			flavour = "macchiato", -- latte, frappe, macchiato, mocha
			background = {
				light = "macchiato",
				dark = "macchiato",
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				treesitter = true,
				notify = true,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
			},

			-- Define custom highlight groups
			custom_highlights = function(colors)
				return {
					["@comment"] = { fg = colors.teal, style = { "italic" } }, -- Apply italic and bold to regular comments
					["@comment.documentation"] = { fg = colors.teal, style = { "italic" } }, -- Apply italic to documentation comments
				}
			end,
		})

		-- Set the colorscheme after the setup
		vim.cmd("colorscheme catppuccin-macchiato")
	end,
}
