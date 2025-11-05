# 1. Backup your existing Neovim config (if you have one)
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
mv ~/.cache/nvim ~/.cache/nvim.backup

# 2. Clone your config repository
git clone https://github.com/Oussama-Ouarezki/Neovim-config.git ~/.config/nvim

# 3. Launch Neovim (plugins should install automatically)
nvim

# 🎥 Manim Neovim Plugin – Custom Shortcuts

This Neovim plugin is a Lua-based wrapper for [Manim](https://www.manim.community/), providing useful keybindings and GUI prompts for rendering scenes directly from your editor.

📁 **File Location:**  
[`lua/custom/plugins/manim.lua`](https://github.com/Oussama-Ouarezki/Neovim-config/blob/main/lua/custom/plugins/manim.lua)

📺 **Demo Video:**  
[YouTube](https://www.youtube.com/watch?v=8xTAmnAm_u8&t=13s)

---

## ⌨️ Keybindings

| Keybinding        | Action                                 |
|-------------------|-----------------------------------------|
| `<leader>ml`      | Run Manim (low quality)                 |
| `<leader>mh`      | Run Manim (high quality)                |
| `<leader>ms`      | Render last frame (low quality)         |
| `<leader>mm`      | Show scene menu                         |
| `<leader>mv`      | Replay last rendered video              |
| `<leader>mV`      | Replay last saved image                 |
| `<leader>mg`      | Render GIF (low quality)                |
| `<leader>mG`      | Render GIF (high quality)               |
| `<leader>mr`      | Replay last rendered GIF                |
| `<leader>md`      | Run Manim dry run (debug only)          |

> These shortcuts assume that the file you're editing contains `Scene`-based classes and that Manim is installed and accessible via CLI.

---

## 🛠 Requirements

- A working terminal (with support for `mpv`, `vlc`, `feh`, etc. depending on your OS)




