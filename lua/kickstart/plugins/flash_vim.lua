return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    -- Disable default keymaps to prevent interference
    default_keymaps = false,
    -- Enhanced configuration
    search = {
      multi_window = true,
      wrap = true,
      incremental = true,
      max_length = 5, -- Allow 2-character inputs
    },
    modes = {
      char = {
        enabled = false, -- Disable enhanced f/t motions
      },
    },
    label = {
      uppercase = false,
      after = true,
      style = 'inline',
    },
  },
  keys = {
    -- Basic jump (2-character)
    {
      'f',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump {
          search = {
            mode = function(pattern)
              return '\\<' .. pattern:sub(1, 2)
            end,
          },
        }
      end,
      desc = 'Flash (2-char)',
    },
    -- Treesitter jump
    {
      'F',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    }, -- Search integration
    {
      't',
      function()
        require('flash').toggle()
        vim.cmd.normal { '?', bang = true }
      end,
      desc = 'Flash Search',
    },
  },
}
