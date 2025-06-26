return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("bufferline").setup {
      options = {
        mode = "buffers", -- use "tabs" to show tabpages instead
        style_preset = require("bufferline").style_preset.default, -- or .minimal
        themable = true,
        numbers = "ordinal", -- shows buffer number
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = {
          icon = "▎",
          style = "icon",
        },
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        always_show_bufferline = true,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = "slant",
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        sort_by = "insert_at_end",

        offsets = {
          {
            filetype = "neo-tree",
            text = " File Explorer",
            highlight = "Directory",
            text_align = "left",
            separator = true,
          },
        },
      },
    }

    -- Optional: Keymaps for cycling buffers
    vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
    vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
  end,
}
