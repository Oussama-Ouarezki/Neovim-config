return {
	{
		"RRethy/nvim-base16",
		lazy = false,                               -- Load the theme early
		priority = 1000,                            -- Ensure it loads before others
		config = function()
			vim.cmd("colorscheme  base16-catppuccin-frappe") -- ✅ Use this theme
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "base16", -- ✅ This auto-detects the base16 colorscheme
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
					lualine_b = { "branch", "diff" },
					lualine_c = { "filename" },
					lualine_x = { "diagnostics" },
					lualine_y = { "filetype", "progress" },
					lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
				},
			})
		end,
	},
}
