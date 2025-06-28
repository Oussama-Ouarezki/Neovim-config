
return {
  { "tpope/vim-fugitive", cmd = { "Git", "G" }, lazy = true },

{
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("gitsigns").setup()
  end,
},


{
  "NeogitOrg/neogit",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Neogit",
  config = function()
    require("neogit").setup()
  end,
}
}
