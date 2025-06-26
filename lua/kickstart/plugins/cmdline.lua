return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {},
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"rcarriga/nvim-notify",
			config = function()
				vim.notify = require("notify")
				vim.keymap.set("n", "<leader>n", function()
					require("notify").dismiss({ silent = true, pending = true })
				end, { desc = "Dismiss Notifications" })
			end,
		},
	}
}
