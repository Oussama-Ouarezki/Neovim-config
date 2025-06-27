return {
	
	
{
  "sainnhe/gruvbox-material",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_background = "soft"
    vim.g.gruvbox_material_foreground = "material" -- Optional: or "mix" / "original"
    vim.g.gruvbox_material_enable_italic = 1
    vim.cmd("colorscheme gruvbox-material")
  end,
}


,

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
