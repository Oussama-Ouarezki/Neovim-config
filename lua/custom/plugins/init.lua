-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Lua
return {
  {
    "abecodes/tabout.nvim",
    lazy = false,
    config = function()
      require("tabout").setup {
        tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = false, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      }
    end,
    dependencies = { -- These are optional
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip",
      "hrsh7th/nvim-cmp",
    },
    opt = true, -- Set this to true if the plugin is optional
    event = "InsertCharPre", -- Set the event to 'InsertCharPre' for better compatibility
    priority = 1000,
  },
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      -- Disable default tab keybinding in LuaSnip
      return {}
    end,
  },
  "sphamba/smear-cursor.nvim",

  opts = {
    cursor_color = "#d3cdc3",
    -- Smear cursor when switching buffers or windows.
    smear_between_buffers = true,

    -- Smear cursor when moving within line or to neighbor lines.
    -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
    smear_between_neighbor_lines = true,

    -- Draw the smear in buffer space instead of screen space when scrolling
    scroll_buffer_space = true,

    -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
    -- Smears will blend better on all backgrounds.
    legacy_computing_symbols_support = false,

    -- Smear cursor in insert mode.
    -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
    smear_insert_mode = true,
  },
}
