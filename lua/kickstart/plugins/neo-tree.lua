-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  "nvim-neo-tree/neo-tree.nvim",
  event = "VeryLazy",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  keys = {
    { "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
  },
  opts = {
    -- open_on_setup = false, -- legacy option (just in case)
    -- open_on_setup_file = false, -- legacy option (just in case)
    filesystem = {

      -- hijack_netrw_behavior = "disabled", -- don't auto open for netrw
      window = {
        mappings = {
          ["\\"] = "close_window",
        },
      },
    },
  },
}
