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
      max_length = 5, -- Allow up to 5-character inputs
    },
    modes = {
      char = {
        enabled = false, -- Disable enhanced f/t motions
      },
      search = {
        enabled = true, -- Enable search mode for better visual selection
      },
    },
    label = {
      uppercase = false,
      after = true,
      style = 'inline',
    },
    -- Add prompt configuration for better visual feedback
    prompt = {
      enabled = true,
      prefix = { { "⚡", "FlashPromptIcon" } },
    },
  },
  keys = {
    -- Flash Jump - works in normal, visual, and operator-pending modes
    {
      't',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash Jump',
    },
    
    -- Treesitter jump
    {
      'T',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    
    -- Additional keymap for remote flash (useful for visual selections)
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
    
    -- Search and replace with flash
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
}
