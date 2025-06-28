
## 🎬 Manim Integration for Neovim

This Lua module provides an enhanced Neovim workflow for [Manim](https://github.com/ManimCommunity/manim), making it easy to render scenes, choose quality settings, and replay outputs directly from the editor.

### ✅ Features

* Run the current scene under cursor with `-ql`, `-qh`, and optional `-s` (last frame) flags
* Auto-detects scene classes in the file
* Scene selector with quality prompt (`<leader>mm`)
* Automatically replays the last rendered video or image (`<leader>mv`, `<leader>mi`)
* Smart terminal management (reuses existing terminal or creates one)
* Automatically saves the file before rendering

### 🎮 Keybindings

| Shortcut      | Action                                  |
| ------------- | --------------------------------------- |
| `<leader>ml`  | Run current scene (Low Quality: `-ql`)  |
| `<leader>mh`  | Run current scene (High Quality: `-qh`) |
| `<leader>msl` | Run and save last frame (`-ql -s`)      |
| `<leader>msh` | Run and save last frame (`-qh -s`)      |
| `<leader>mm`  | Select scene and render via menu        |
| `<leader>mv`  | Replay last rendered video              |
| `<leader>mi`  | Replay last rendered image              |

Sure! Here's a clearer and more polished version of your note:

---

> **Note:**
> For the best experience when replaying videos, it's recommended to use **`mpv`**. It gives you convenient keyboard controls:
>
> * `space` to pause/play
> * `,` and `.` to rewind or fast forward frame-by-frame
> * `q` to quit
>
> This means you won't need to use your mouse to control playback.
>
> For images, use a lightweight viewer like **`feh`**, which also lets you quit quickly with `q`. You can set it as your default image viewer or call it directly from the terminal for smooth integration.
https://github.com/Oussama-Ouarezki/Neovim-config/tree/main/lua/custom/plugins
