-- Manim configuration

local M = {}

-- Global variables to track last execution
_G.manim_last_video = nil
_G.manim_last_image = nil
_G.manim_last_gif = nil

-- Helper function to get current file directory
local function get_file_dir()
  return vim.fn.expand('%:p:h')
end

-- Helper function to get current filename
local function get_filename()
  return vim.fn.expand('%:t')
end

-- Helper function to find all scenes in current file
local function find_all_scenes()
  local scenes = {}
  local total_lines = vim.fn.line('$')
  
  for line_num = 1, total_lines do
    local line_content = vim.fn.getline(line_num)
    local class_match = string.match(line_content, "^%s*class%s+([%w_]+)%s*%(.*Scene")
    if class_match then
      table.insert(scenes, class_match)
    end
  end
  
  return scenes
end

-- Helper function to find scene at cursor
local function find_scene_at_cursor()
  local current_line = vim.fn.line('.')
  local scene_name = nil
  
  -- Search upward from cursor
  for line_num = current_line, 1, -1 do
    local line_content = vim.fn.getline(line_num)
    local class_match = string.match(line_content, "^%s*class%s+([%w_]+)%s*%(.*Scene")
    if class_match then
      scene_name = class_match
      break
    end
  end
  
  -- If no scene found upward, search downward
  if not scene_name then
    local total_lines = vim.fn.line('$')
    for line_num = current_line + 1, total_lines do
      local line_content = vim.fn.getline(line_num)
      local class_match = string.match(line_content, "^%s*class%s+([%w_]+)%s*%(.*Scene")
      if class_match then
        scene_name = class_match
        break
      end
    end
  end
  
  return scene_name
end

-- Helper function to execute command in terminal
local function execute_in_terminal(cmd, auto_close, switch_back)
  if auto_close == nil then auto_close = true end
  if switch_back == nil then switch_back = true end
  
  -- Store current window for switching back
  local original_win = vim.api.nvim_get_current_win()
  
  -- Check if terminal buffer exists
  local term_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal' then
      term_buf = buf
      break
    end
  end
  
  if term_buf then
    -- If terminal exists, find its window or create new one
    local term_win = nil
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == term_buf then
        term_win = win
        break
      end
    end
    
    if not term_win then
      -- Terminal buffer exists but no window, create vertical split
      vim.cmd('rightbelow vsplit')
      vim.api.nvim_win_set_buf(0, term_buf)
      term_win = vim.api.nvim_get_current_win()
    end
    
    -- Focus terminal window and send command
    vim.api.nvim_set_current_win(term_win)
    
    if auto_close then
      -- Add exit command after main command
      vim.api.nvim_chan_send(vim.api.nvim_buf_get_option(term_buf, 'channel'), cmd .. ' && exit\n')
    else
      vim.api.nvim_chan_send(vim.api.nvim_buf_get_option(term_buf, 'channel'), cmd .. '\n')
    end
  else
    -- Create new terminal in vertical split
    vim.cmd('rightbelow vsplit')
    vim.cmd('terminal')
    
    if auto_close then
      -- Add exit command after main command
      vim.api.nvim_chan_send(vim.api.nvim_buf_get_option(0, 'channel'), cmd .. ' && exit\n')
    else
      vim.api.nvim_chan_send(vim.api.nvim_buf_get_option(0, 'channel'), cmd .. '\n')
    end
  end
  
  -- Switch back to original window (simulate Ctrl+h)
  if switch_back then
    vim.defer_fn(function()
      vim.api.nvim_set_current_win(original_win)
    end, 100) -- Small delay to ensure command is sent first
  end
end

-- Helper function to get video/image/gif paths (common Manim output structure)
local function get_output_paths(filename, scene_name, quality)
  local base_name = filename:gsub("%.py$", "")
  local quality_folder = quality == "l" and "480p15" or "1080p60"
  
  local video_path = string.format("%s/media/videos/%s/%s/%s.mp4", 
    get_file_dir(), base_name, quality_folder, scene_name)
  
  -- For images, find the actual file with ManimCE version suffix
  local image_base_path = string.format("%s/media/images/%s", get_file_dir(), base_name)
  local image_pattern = string.format("%s/%s_ManimCE_v*.png", image_base_path, scene_name)
  local found_images = vim.fn.glob(image_pattern, false, true)
  local image_path = #found_images > 0 and found_images[1] or 
    string.format("%s/%s.png", image_base_path, scene_name)
  
  local gif_path = string.format("%s/media/videos/%s/%s/%s.gif", 
    get_file_dir(), base_name, quality_folder, scene_name)
    
  return video_path, image_path, gif_path
end

-- Core manim execution function
local function run_manim_with_options(quality, last_frame, scene_name_override, format, dry_run)
  -- Save current file
  vim.cmd('write')
  
  local filename = get_filename()
  local current_dir = get_file_dir()
  local scene_name = scene_name_override or find_scene_at_cursor()
  
  if not scene_name then
    print("No scene class found!")
    return
  end
  
  -- Build quality flag
  local quality_flag = quality == "h" and "-qh" or "-ql"
  
  -- Build manim command with debug flag
  local flags = quality_flag .. " -p"
  if last_frame then
    flags = flags .. " -s"
  end
  if format == "gif" then
    flags = flags .. " --format gif"
  end
  if dry_run then
    flags = flags .. " --dry_run"
  end
  
  local manim_cmd = string.format("cd %s && manim %s %s %s", 
    current_dir, flags, filename, scene_name)
  
  -- Store paths for replay functionality (only if not dry run)
  if not dry_run then
    local video_path, image_path, gif_path = get_output_paths(filename, scene_name, quality)
    _G.manim_last_video = video_path
    _G.manim_last_image = image_path
    _G.manim_last_gif = gif_path
  end
  
  print(string.format("Running: %s", manim_cmd))
  
  -- For dry run, keep terminal open to see debug output
  local auto_close = not dry_run
  execute_in_terminal(manim_cmd, auto_close, true) -- auto_close based on dry_run, switch_back=true
end

-- Scene selection menu
local function show_scene_menu()
  local scenes = find_all_scenes()
  
  if #scenes == 0 then
    print("No scenes found in current file!")
    return
  end
  
  -- Create menu items
  local menu_items = {}
  for i, scene in ipairs(scenes) do
    table.insert(menu_items, string.format("%d. %s", i, scene))
  end
  
  -- Add separator and replay options
  table.insert(menu_items, "")
  table.insert(menu_items, "r. Replay last video")
  table.insert(menu_items, "i. Replay last image")
  table.insert(menu_items, "g. Replay last GIF")
  
  vim.ui.select(menu_items, {
    prompt = "Select scene or action:",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if not choice then return end
    
    if choice:match("^%d+%.") then
      -- Extract scene number and run with medium quality
      local scene_num = tonumber(choice:match("^(%d+)%."))
      local selected_scene = scenes[scene_num]
      if selected_scene then
        -- Ask for quality and options
        vim.ui.select({
          "Low quality (-ql)",
          "High quality (-qh)", 
          "Low quality + Last frame (-ql -s)",
          "High quality + Last frame (-qh -s)",
          "Low quality GIF (-ql --format gif)",
          "High quality GIF (-qh --format gif)",
          "Dry run (-ql --dry_run)"
        }, {
          prompt = "Select quality and options:"
        }, function(option)
          if not option then return end
          
          local quality = option:match("High") and "h" or "l"
          local last_frame = option:match("Last frame") and true or false
          local format = option:match("GIF") and "gif" or nil
          local dry_run = option:match("Dry run") and true or false
          
          run_manim_with_options(quality, last_frame, selected_scene, format, dry_run)
        end)
      end
    elseif choice:match("Replay last video") then
      M.replay_video()
    elseif choice:match("Replay last image") then
      M.replay_image()
    elseif choice:match("Replay last GIF") then
      M.replay_gif()
    end
  end)
end

-- Replay functions
function M.replay_video()
  if not _G.manim_last_video then
    print("No video to replay! Run manim first.")
    return
  end
  
  -- Check if file exists before trying to open
  if vim.fn.filereadable(_G.manim_last_video) == 0 then
    print("Video file not found: " .. _G.manim_last_video)
    return
  end
  
  -- Try different video players with loop flag
  local players = {"mpv", "vlc", "open", "xdg-open"}
  local cmd = nil
  
  for _, player in ipairs(players) do
    if vim.fn.executable(player) == 1 then
      if player == "mpv" then
        cmd = string.format("mpv --loop '%s'", _G.manim_last_video)
      elseif player == "vlc" then
        cmd = string.format("vlc --loop '%s'", _G.manim_last_video)
      elseif player == "open" then
        cmd = string.format("open '%s'", _G.manim_last_video)
      else
        cmd = string.format("xdg-open '%s'", _G.manim_last_video)
      end
      break
    end
  end
  
  if cmd then
    execute_in_terminal(cmd, false, true) -- auto_close=false, switch_back=true
  else
    print("No video player found! Install mpv, vlc, or ensure system default player is available.")
  end
end

function M.replay_image()
  if not _G.manim_last_image then
    print("No image to replay! Run manim with -s flag first.")
    return
  end
  
  -- Check if file exists before trying to open
  if vim.fn.filereadable(_G.manim_last_image) == 0 then
    print("Image file not found, searching for ManimCE versioned file...")
    
    -- Try to find the image with ManimCE version suffix
    local filename = get_filename():gsub("%.py$", "")
    local scene_name = find_scene_at_cursor()
    if scene_name then
      local image_pattern = string.format("%s/media/images/%s/%s_ManimCE_v*.png", 
        get_file_dir(), filename, scene_name)
      local found_files = vim.fn.glob(image_pattern, false, true)
      
      if #found_files > 0 then
        _G.manim_last_image = found_files[1]
        print("Found image at: " .. _G.manim_last_image)
      else
        print("Could not find image file with pattern: " .. image_pattern)
        print("Try running manim with -s flag first.")
        return
      end
    else
      print("No scene found to search for image.")
      return
    end
  end
  
  -- Try different image viewers
  local viewers = {"feh", "eog", "open", "xdg-open", "display"}
  local cmd = nil
  
  for _, viewer in ipairs(viewers) do
    if vim.fn.executable(viewer) == 1 then
      if viewer == "feh" then
        cmd = string.format("feh '%s'", _G.manim_last_image)
      elseif viewer == "eog" then
        cmd = string.format("eog '%s'", _G.manim_last_image)
      elseif viewer == "display" then
        cmd = string.format("display '%s'", _G.manim_last_image)
      elseif viewer == "open" then
        cmd = string.format("open '%s'", _G.manim_last_image)
      else
        cmd = string.format("xdg-open '%s'", _G.manim_last_image)
      end
      break
    end
  end
  
  if cmd then
    execute_in_terminal(cmd, false, true) -- auto_close=false, switch_back=true
  else
    print("No image viewer found! Install feh, eog, imagemagick (display), or ensure system default viewer is available.")
  end
end

function M.replay_gif()
  if not _G.manim_last_gif then
    print("No GIF to replay! Run manim with GIF format first.")
    return
  end
  
  -- Check if file exists before trying to open
  if vim.fn.filereadable(_G.manim_last_gif) == 0 then
    print("GIF file not found: " .. _G.manim_last_gif)
    return
  end
  
  -- Try different viewers that can handle GIFs
  local viewers = {"feh", "eog", "mpv", "vlc", "open", "xdg-open"}
  local cmd = nil
  
  for _, viewer in ipairs(viewers) do
    if vim.fn.executable(viewer) == 1 then
      if viewer == "feh" then
        cmd = string.format("feh --auto-zoom '%s'", _G.manim_last_gif)
      elseif viewer == "eog" then
        cmd = string.format("eog '%s'", _G.manim_last_gif)
      elseif viewer == "mpv" then
        cmd = string.format("mpv --loop '%s'", _G.manim_last_gif)
      elseif viewer == "vlc" then
        cmd = string.format("vlc --loop '%s'", _G.manim_last_gif)
      elseif viewer == "open" then
        cmd = string.format("open '%s'", _G.manim_last_gif)
      else
        cmd = string.format("xdg-open '%s'", _G.manim_last_gif)
      end
      break
    end
  end
  
  if cmd then
    execute_in_terminal(cmd, false, true) -- auto_close=false, switch_back=true
  else
    print("No GIF viewer found! Install feh, eog, mpv, or ensure system default viewer is available.")
  end
end

-- Main functions for keybindings
function M.run_low_quality()
  run_manim_with_options("l", false)
end

function M.run_high_quality() 
  run_manim_with_options("h", false)
end

function M.run_last_frame_low()
  run_manim_with_options("l", true)
end

function M.run_last_frame_high()
  run_manim_with_options("h", true)
end

function M.run_gif_low()
  run_manim_with_options("l", false, nil, "gif")
end

function M.run_gif_high()
  run_manim_with_options("h", false, nil, "gif")
end

function M.run_dry_run()
  run_manim_with_options("l", false, nil, nil, true)
end

-- Set up keybindings
vim.keymap.set('n', '<leader>ml', M.run_low_quality, { desc = 'Manim: Run low quality' })
vim.keymap.set('n', '<leader>mh', M.run_high_quality, { desc = 'Manim: Run high quality' })
vim.keymap.set('n', '<leader>ms', M.run_last_frame_low, { desc = 'Manim: Last frame low quality' })
-- vim.keymap.set('n', '<leader>msh', M.run_last_frame_high, { desc = 'Manim: Last frame high quality' })
vim.keymap.set('n', '<leader>mm', show_scene_menu, { desc = 'Manim: Scene menu' })
vim.keymap.set('n', '<leader>mv', M.replay_video, { desc = 'Manim: Replay last video' })
vim.keymap.set('n', '<leader>mV', M.replay_image, { desc = 'Manim: Replay last image' })
vim.keymap.set('n', '<leader>mg', M.run_gif_low, { desc = 'Manim: Render GIF low quality' })
vim.keymap.set('n', '<leader>mG', M.run_gif_high, { desc = 'Manim: Render GIF high quality' })
vim.keymap.set('n', '<leader>mr', M.replay_gif, { desc = 'Manim: Replay last GIF' })
vim.keymap.set('n', '<leader>md', M.run_dry_run, { desc = 'Manim: Dry run (debug)' })

return M
