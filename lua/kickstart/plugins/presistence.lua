return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- starts session saving only if a file is opened
  opts = {
    dir = vim.fn.stdpath "state" .. "/sessions/", -- default
    options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions (optional)
    pre_save = nil, -- custom function to run before saving
    save_empty = false, -- don't save if there are no buffers
    load_last = true, -- auto load last session
    branch = true, -- use git branch as session key
  },
  keys = {
    {
      "<leader>qs",
      function()
        require("persistence").load()
      end,
      desc = "Load session for current dir",
    },
    {
      "<leader>qS",
      function()
        require("persistence").select()
      end,
      desc = "Select session to load",
    },
    {
      "<leader>ql",
      function()
        require("persistence").load { last = true }
      end,
      desc = "Load last session",
    },
    {
      "<leader>qd",
      function()
        require("persistence").stop()
      end,
      desc = "Stop session saving",
    },
  },
}
