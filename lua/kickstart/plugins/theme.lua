return {
	
	


{
  "sainnhe/gruvbox-material",
  lazy = false,
  priority = 1000,
  config = function()
    -- Gruvbox Material settings
    vim.g.gruvbox_material_background = "soft"
    vim.g.gruvbox_material_foreground = "material"
    vim.g.gruvbox_material_enable_italic = 1

    -- Apply the colorscheme
    vim.cmd("colorscheme gruvbox-material")

    -- Custom diagnostic colors (Errors, Warnings, Info, Hints)
    vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#fb4934" })  -- Red
    vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = "#fabd2f" })  -- Yellow
    vim.api.nvim_set_hl(0, "DiagnosticInfo",  { fg = "#83a598" })  -- Light Blue
    vim.api.nvim_set_hl(0, "DiagnosticHint",  { fg = "#8ec07c" })  -- Aqua

    -- Optional: underline the diagnostics too
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#fb4934" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = "#fabd2f" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",  { undercurl = true, sp = "#83a598" })
    vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",  { undercurl = true, sp = "#8ec07c" })
  end,
}




,

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
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
