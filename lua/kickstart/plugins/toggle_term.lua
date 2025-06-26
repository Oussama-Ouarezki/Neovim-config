return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
        return 20
      end,
      open_mapping = [[<>]],
      direction = "float",
      float_opts = {
        border = "curved",
        width = 150,
        height = 30,
        winblend = 15,
      },
      -- Disable unused callbacks (remove if you need them)
      on_create = function() end,
      on_open = function() end,
      on_close = function() end,
    }
    vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm<cr>", { desc = "Toggle Floating Terminal" })

    local term_bufnr = nil

    vim.keymap.set("n", "<leader>tt", function()
      -- If terminal is open, close it
      if term_bufnr and vim.api.nvim_buf_is_valid(term_bufnr) then
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_buf(win) == term_bufnr then
            vim.api.nvim_win_close(win, true)
            term_bufnr = nil
            return
          end
        end
      end

      -- Otherwise, open a new terminal in split
      local dir = vim.fn.expand "%:p:h"
      vim.cmd "split"
      vim.cmd "resize 7 "
      vim.cmd("terminal bash -c 'cd " .. dir .. "; exec bash'")
      term_bufnr = vim.api.nvim_get_current_buf()
    end, { desc = "Toggle horizontal terminal in current file dir" })
  end,
}
