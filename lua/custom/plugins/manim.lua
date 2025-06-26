local last_video_path = nil
local last_image_path = nil

local function get_class_name()
  local node = vim.treesitter.get_node()
  while node do
    if node:type() == "class_definition" then
      local name_node = node:field("name")[1]
      if name_node then
        return vim.treesitter.get_node_text(name_node, 0)
      end
    end
    node = node:parent()
  end
  return nil
end

-- Helper function to get expected video path based on manim's structure
local function get_expected_video_path(quality, class_name)
  local file_path = vim.fn.expand("%:p")
  local dir_name = vim.fn.expand("%:p:h")
  local file_name = vim.fn.expand("%:t:r")
  
  local quality_folder
  if quality == "-ql" then
    quality_folder = "480p15"
  elseif quality == "-qm" then
    quality_folder = "720p30"
  elseif quality == "-qh" then
    quality_folder = "1080p60"
  else
    quality_folder = "480p15"
  end
  
  -- Manim's default structure: ./media/videos/filename/quality/SceneName.mp4
  return dir_name .. "/media/videos/" .. file_name .. "/" .. quality_folder .. "/" .. class_name .. ".mp4"
end

-- Helper function to get expected image path based on manim's structure
local function get_expected_image_path(class_name)
  local file_path = vim.fn.expand("%:p")
  local dir_name = vim.fn.expand("%:p:h")
  local file_name = vim.fn.expand("%:t:r")
  
  -- Manim's default structure: ./media/images/filename/SceneName_ManimCE_v0.18.1.png
  -- But the exact name can vary, so we'll look for any PNG with the scene name
  return dir_name .. "/media/images/" .. file_name .. "/"
end

local function render_scene(quality)
  local class_name = get_class_name()
  if not class_name then
    print("No class name found at cursor position!")
    return
  end
  
  vim.cmd("write") -- Save file
  local file_path = vim.fn.expand("%:p")
  
  -- Set expected video path for later preview
  last_video_path = get_expected_video_path(quality, class_name)
  
  -- Let manim handle all the directory creation and file placement
  -- Chain commands: render then preview with mpv
  local cmd = string.format("manim --disable_caching -v DEBUG %s '%s' '%s' && mpv '%s'", 
    quality, file_path, class_name, last_video_path)
  
  require("toggleterm.terminal").Terminal:new({
    cmd = cmd,
    direction = "vertical",
    close_on_exit = true,
    size = 60,
    on_open = function(term)
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
  }):toggle()
  
  -- Auto focus back to code (left window) after command is sent
  vim.defer_fn(function()
    vim.cmd("wincmd h")
  end, 200)
end

local function preview_last_video()
  if not last_video_path then
    print("No video rendered yet!")
    return
  end
  
  -- Check if the video file actually exists
  if vim.fn.filereadable(last_video_path) == 0 then
    print("Video file not found at expected location: " .. last_video_path)
    return
  end
  
  local cmd = string.format("mpv --loop '%s'", last_video_path)
  require("toggleterm.terminal").Terminal:new({
    cmd = cmd,
    direction = "vertical",
    close_on_exit = true,
    size = 60,
    on_open = function(term)
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
  }):toggle()
end

local function render_image()
  local class_name = get_class_name()
  if not class_name then
    print("No class name found at cursor position!")
    return
  end
  
  vim.cmd("write") -- Save file
  local file_path = vim.fn.expand("%:p")
  
  -- Set expected image directory for later reference
  last_image_path = get_expected_image_path(class_name)
  
  -- Let manim handle the image creation and placement
  -- Add -p flag to preview automatically after rendering
  local cmd = string.format("manim -ql -s -p '%s' '%s'", file_path, class_name)
  
  require("toggleterm.terminal").Terminal:new({
    cmd = cmd,
    direction = "vertical",
    close_on_exit = true,
    size = 60,
    on_open = function(term)
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
  }):toggle()
  
  -- Auto focus back to code (left window) after command is sent
  vim.defer_fn(function()
    vim.cmd("wincmd h")
  end, 200)
end

-- Function to preview the last rendered image
local function preview_last_image()
  if not last_image_path then
    print("No image rendered yet!")
    return
  end
  
  -- Find the actual image file (manim adds version info to filename)
  local dir_name = vim.fn.expand("%:p:h")
  local file_name = vim.fn.expand("%:t:r")
  local class_name = get_class_name()
  
  if not class_name then
    print("No class name found!")
    return
  end
  
  local images_dir = dir_name .. "/media/images/" .. file_name .. "/"
  
  -- Look for PNG files with the scene name
  local image_files = vim.fn.glob(images_dir .. class_name .. "*.png", false, true)
  
  if #image_files == 0 then
    print("No image files found in: " .. images_dir)
    return
  end
  
  -- Use the first (most recent) image file
  local image_path = image_files[1]
  
  -- Open image with default viewer
  local cmd = string.format("xdg-open '%s'", image_path) -- Linux
  -- For macOS: local cmd = string.format("open '%s'", image_path)
  -- For Windows: local cmd = string.format("start '%s'", image_path)
  
  vim.fn.system(cmd)
  print("Opening image: " .. vim.fn.fnamemodify(image_path, ":t"))
end

-- Function to open the media folder in file manager
local function open_media_folder()
  local dir_name = vim.fn.expand("%:p:h")
  local media_dir = dir_name .. "/media"
  
  if vim.fn.isdirectory(media_dir) == 0 then
    print("No media directory found!")
    return
  end
  
  -- Open file manager (adjust for your OS)
  local cmd = string.format("xdg-open '%s'", media_dir) -- Linux
  -- For macOS: local cmd = string.format("open '%s'", media_dir)
  -- For Windows: local cmd = string.format("explorer '%s'", media_dir)
  
  vim.fn.system(cmd)
end

-- Keybindings
vim.keymap.set("n", "<leader>ml", function()
  render_scene("-ql")
end, { noremap = true, silent = true, desc = "Render Manim (Low Quality)" })

vim.keymap.set("n", "<leader>mm", function()
  render_scene("-qm")
end, { noremap = true, silent = true, desc = "Render Manim (Medium Quality)" })

vim.keymap.set("n", "<leader>mh", function()
  render_scene("-qh")
end, { noremap = true, silent = true, desc = "Render Manim (High Quality)" })

vim.keymap.set("n", "<leader>ms", render_image, {
  noremap = true,
  silent = true,
  desc = "Render Manim Still Frame (Low Quality)",
})

vim.keymap.set("n", "<leader>mv", preview_last_video, {
  noremap = true,
  silent = true,
  desc = "Preview Last Rendered Video (Looping)",
})

vim.keymap.set("n", "<leader>mi", preview_last_image, {
  noremap = true,
  silent = true,
  desc = "Preview Last Rendered Image",
})

vim.keymap.set("n", "<leader>mo", open_media_folder, {
  noremap = true,
  silent = true,
  desc = "Open Media Folder",
})
