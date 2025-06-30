-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    check_ts = true,  -- optional: enable treesitter integration
    enable_check_bracket_line = false,  -- allow autopairs on the same line
    ignored_next_char = "",  -- do not skip over closing bracket
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
  end,
}
