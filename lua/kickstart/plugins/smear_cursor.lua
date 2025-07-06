return {
  "sphamba/smear-cursor.nvim",
  opts = {
    -- Enable all smearing options
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,
    legacy_computing_symbols_support = false,
    smear_insert_mode = true,
    
    -- Make it super sensitive to movement
    min_horizontal_distance_smear = 1, -- Smear on ANY horizontal movement
    min_vertical_distance_smear = 1,   -- Smear on ANY vertical movement
    
    -- Maximize animation intensity
    max_smear_length = 100,            -- Longer trails
    smear_transparency = 0.6,          -- More visible trails
    normal_bg_priority = 200,          -- Higher priority for better blending
    
    -- More fluid animation timing
    stiffness = 0.6,                   -- Slower catch-up = more visible animation
    trailing_stiffness = 0.3,          -- Much slower trail = longer smear effect
    distance_stop_animating = 0.1,     -- Animate even tiny movements
    hide_target_hack = false,
    
    -- Additional animation enhancers
    smear_transparency_decrease_rate = 0.8, -- Slower fade = longer visible trails
    color_levels = 16,                 -- More color gradations in trail
    
    -- Make insert mode extra animated
    vertical_bar_cursor_insert_mode = true,
    distance_stop_animating_vertical_bar = 0.1,
  },
}

