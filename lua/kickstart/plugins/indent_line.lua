
-- File: lua/custom/plugins/indent_context.lua
return {

  -- Treesitter context (shows top of current scope)
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = {
      enable = true,
      throttle = true,
      max_lines = 3, -- show up to 3 lines of context
    },
  },

  -- Indent line with animation and scope highlighting
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "│", -- or try "▏"
        highlight = "IndentLineBlue", -- custom highlight below
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        highlight = { "IndentLineBlue" },
        injected_languages = true,
      },
    },
    config = function(_, opts)
      -- Set up indent-blankline with provided options
      require("ibl").setup(opts)

      -- Define custom highlight group with animation-like color
      vim.api.nvim_set_hl(0, "IndentLineBlue", { fg = "#5fafff", nocombine = true })

      -- Optional: animate effect (manual)
      -- You can simulate animation via CursorHold autocmd with different highlight stages
    end,
  },

}
