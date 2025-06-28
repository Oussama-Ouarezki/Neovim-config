return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      direction = "float", -- default
      open_mapping = [[<c-\>]],
      float_opts = {
        border = "curved",
      },
    })

    local Terminal = require("toggleterm.terminal").Terminal

    -- Get current buffer directory
    local function current_dir()
      return vim.fn.expand("%:p:h")
    end

    -- Float terminal
    function _FLOAT_TERM()
      local float = Terminal:new({
        dir = current_dir(),
        direction = "float",
        hidden = true,
      })
      float:toggle()
    end

    -- Horizontal terminal
    function _HORIZ_TERM()
      local horiz = Terminal:new({
        dir = current_dir(),
        direction = "horizontal",
        hidden = true,
      })

      horiz:toggle()
    end

    -- Vertical terminal
    function _VERT_TERM()
      local vert = Terminal:new({
        dir = current_dir(),
        direction = "vertical",
        hidden = true,
      })
      vert:toggle()
    end

    -- Optional keymaps
    vim.keymap.set("n", "<leader>tf", _FLOAT_TERM, { desc = "Toggle Float Term (cwd)" })
    vim.keymap.set("n", "<leader>th", _HORIZ_TERM, { desc = "Toggle Horizontal Term (cwd)" })
    vim.keymap.set("n", "<leader>tv", _VERT_TERM, { desc = "Toggle Vertical Term (cwd)" })
  end,
}
