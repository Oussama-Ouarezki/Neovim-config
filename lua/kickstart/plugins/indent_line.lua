
return {
  -- Treesitter context (shows top of current scope)
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = {
      enable = true,
      throttle = true,
      max_lines = 4,
      line_numbers = true,
      multiline_threshold = 2,
      separator = nil,
    },
  },
  -- Animated indent lines like NvChad
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      symbol = "│",
      options = { 
        try_as_border = true,
        indent_at_cursor = true,
      },
      draw = {
        delay = 100,
        animation = function(s, n)
          return s / n * 20
        end,
      },
      mappings = {
        object_scope = "ii",
        object_scope_with_border = "ai",
        goto_top = "[i",
        goto_bottom = "]i",
      },
    },
    config = function(_, opts)
      require("mini.indentscope").setup(opts)
      
      -- Gruvbox colors
      local gruvbox = {
        orange = "#fe8019",
        yellow = "#fabd2f", 
        green = "#b8bb26",
        aqua = "#8ec07c",
        blue = "#83a598",
        purple = "#d3869b",
      }
      
      -- Set the animated scope color
      vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = gruvbox.orange })
    end,
  },
  -- Regular indent lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "▏",
        tab_char = "▏",
        smart_indent_cap = true,
      },
      whitespace = {
        highlight = "Whitespace",
        remove_blankline_trail = false,
      },
      scope = {
        enabled = false, -- Disable since we use mini.indentscope
      },
      exclude = {
        filetypes = {
          "help",
          "alpha", 
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        buftypes = { "terminal", "nofile", "quickfix", "prompt" },
      },
    },
    config = function(_, opts)
      require("ibl").setup(opts)
      
      -- Gruvbox subtle indent lines
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#504945" })
      vim.api.nvim_set_hl(0, "IblWhitespace", { fg = "#504945" })
    end,
  },
  -- Rainbow indent animation (NvChad style)
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      
      -- Gruvbox rainbow colors
      local gruvbox_rainbow = {
        "#fe8019", -- orange
        "#fabd2f", -- yellow
        "#b8bb26", -- green
        "#8ec07c", -- aqua
        "#83a598", -- blue
        "#d3869b", -- purple
      }
      
      -- Set up rainbow colors
      for i, color in ipairs(gruvbox_rainbow) do
        vim.api.nvim_set_hl(0, "RainbowDelimiterRed" .. i, { fg = color })
        vim.api.nvim_set_hl(0, "RainbowDelimiterYellow" .. i, { fg = color })
        vim.api.nvim_set_hl(0, "RainbowDelimiterBlue" .. i, { fg = color })
        vim.api.nvim_set_hl(0, "RainbowDelimiterOrange" .. i, { fg = color })
        vim.api.nvim_set_hl(0, "RainbowDelimiterGreen" .. i, { fg = color })
        vim.api.nvim_set_hl(0, "RainbowDelimiterViolet" .. i, { fg = color })
        vim.api.nvim_set_hl(0, "RainbowDelimiterCyan" .. i, { fg = color })
      end
      
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
          python = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
          python = 210,
        },
        highlight = {
          "RainbowDelimiterRed1",
          "RainbowDelimiterYellow2", 
          "RainbowDelimiterBlue3",
          "RainbowDelimiterOrange4",
          "RainbowDelimiterGreen5",
          "RainbowDelimiterViolet6",
        },
      }
    end,
  },
  -- Enhanced animation with custom autocmds
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
    config = function()
      -- Custom animation logic for indent lines
      local animation_group = vim.api.nvim_create_augroup("IndentLineAnimation", { clear = true })
      local animation_timer = nil
      local animation_active = false
      local current_frame = 1
      local max_frames = 6
      
      -- Gruvbox animation colors
      local anim_colors = {
        "#fe8019", -- orange
        "#fd7c00", -- orange-red
        "#fabd2f", -- yellow
        "#b8bb26", -- green  
        "#8ec07c", -- aqua
        "#83a598", -- blue
      }
      
      -- Commented out color changing animation
      -- local function animate_indent_scope()
      --   if animation_active then
      --     current_frame = (current_frame % max_frames) + 1
      --     
      --     -- Update mini.indentscope color
      --     vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { 
      --       fg = anim_colors[current_frame],
      --       bold = true 
      --     })
      --     
      --     -- Trigger redraw
      --     vim.schedule(function()
      --       if vim.api.nvim_get_current_buf() then
      --         vim.cmd("redraw")
      --       end
      --     end)
      --   end
      -- end
      
      -- local function start_indent_animation()
      --   if not animation_active then
      --     animation_active = true
      --     if animation_timer then
      --       animation_timer:stop()
      --     end
      --     animation_timer = vim.loop.new_timer()
      --     animation_timer:start(0, 200, vim.schedule_wrap(animate_indent_scope))
      --   end
      -- end
      
      -- local function stop_indent_animation()
      --   if animation_active then
      --     animation_active = false
      --     if animation_timer then
      --       animation_timer:stop()
      --     end
      --     
      --     -- Reset to default orange
      --     vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { 
      --       fg = "#fe8019",
      --       bold = false 
      --     })
      --     current_frame = 1
      --     
      --     vim.schedule(function()
      --       if vim.api.nvim_get_current_buf() then
      --         vim.cmd("redraw")
      --       end
      --     end)
      --   end
      -- end
      
      -- Start animation on insert mode
      -- vim.api.nvim_create_autocmd("InsertEnter", {
      --   group = animation_group,
      --   callback = start_indent_animation,
      -- })
      
      -- Stop animation when leaving insert mode
      -- vim.api.nvim_create_autocmd({ "InsertLeave", "BufLeave" }, {
      --   group = animation_group,
      --   callback = stop_indent_animation,
      -- })
      
      -- Keep scope line static - no color changes
      -- vim.api.nvim_create_autocmd("CursorMoved", {
      --   group = animation_group,
      --   callback = function()
      --     if vim.fn.mode() == "n" and not animation_active then
      --       -- Keep the default orange color stable
      --       vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { 
      --         fg = "#fe8019",
      --         bold = false 
      --       })
      --     end
      --   end,
      -- })
    end,
  },
}
