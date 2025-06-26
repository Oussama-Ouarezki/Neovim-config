return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  config = function()
    local alpha = require "alpha"
    local dashboard = require "alpha.themes.dashboard"
    local devicons = require "nvim-web-devicons"

    -- Function to generate dynamic header
    local function get_header()
      return {
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⠶⠶⠶⢦⣄⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⡆⠀⠀⠀⠀⠀⠀⣄⠀⠀⠀⠀⠀⠀⣴⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡏⠀⠀⠀⠀⠀⠈⠓⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡀⠀⠀⠀⠀⣸⠻⡄⠀⠀⠀⠀⢰⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢧⡀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣤⣿⡤⠤⡄⠀⠀⠀⣀⡤⠴⠶⠤⣤⡀⠀⠀⠀⠀⠀⣀⡤⠶⠶⢤⣄⠀⠀⠀⠀⣇⢀⡤⠶⠶⢤⣄⠀⠀⠀⠀⠀⠀⣠⡤⠶⠦⢤⣄⠀⠀⠀⠀⠀⣠⠤⠶⠦⢤⣀⠀⠀⡤⣼⣧⠤⣤⠀⠀⠀⣤⠀⠀⠀⠀⠀⣠⠤⠶⠶⢤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣇⠀⠀⠀⢀⡏⠀⢧⠀⠀⠀⠀⡾⠀⠀⢀⣤⠤⠶⠦⢤⣀⠀⠀⠀⢤⡀⠀⠀⠀⠀⠀⢀⡤⠀⠀⣠⠤⠶⠦⢤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠓⠒⠶⢤⣄⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⣼⠋⠀⠀⠀⠀⠀⠹⣆⠀⠀⠀⣼⠋⠀⠀⠀⠀⠈⠃⠀⠀⠀⡿⠁⠀⠀⠀⠀⠈⢷⠀⠀⠀⢠⡞⠁⠀⠀⠀⠀⠈⢷⡀⠀⠀⢸⡇⠀⠀⠀⠀⠉⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⣿⠀⠀⠀⢀⡾⠁⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⢹⡄⠀⠀⣼⠀⠀⠸⡆⠀⠀⢸⠃⠀⣰⠏⠀⠀⠀⠀⠀⠙⣧⠀⠀⠈⢷⡀⠀⠀⠀⠀⡼⠁⠀⢸⡇⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⢰⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⢘⡇⠀⠀⠀⠙⠒⠦⠤⣤⡀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⣿⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢷⠀⢠⡇⠀⠀⠀⢻⠀⢀⡟⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⢸⡆⠀⠀⠈⢷⡀⠀⠀⣼⠃⠀⠀⠀⠙⠓⠦⠤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢤⡀⠀⠀⠀⠀⠀⠀⣼⠀⠀⠀⠀⢿⡀⠀⠀⠀⠀⢷⡀⠀⠀⠀⠀⠀⢠⡟⠀⠀⠀⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠸⣆⠀⠀⠀⠀⠀⠀⣼⡇⠀⠀⠀⠀⠀⠀⠀⠀⢹⡆⠀⠀⢸⡇⠀⠀⠀⠀⠀⣿⠀⠀⠀⠘⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣆⡼⠀⠀⠀⠀⠘⣇⣼⠁⠀⠀⢻⣄⠀⠀⠀⠀⠀⢀⣾⡇⠀⠀⠀⠈⢷⠀⣼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠶⢤⣤⣤⠴⠞⠁⠀⠀⠀⠀⠈⠳⠦⠤⠀⠀⠀⠙⠶⠤⠤⠤⠖⠋⠀⠀⠀⠀⠈⠛⠦⠤⠤⠤⠖⠃⠀⠀⠀⠇⠀⠀⠀⠀⠀⠀⠸⠇⠀⠀⠀⠘⠳⠦⠤⠤⠴⠊⠩⠇⠀⠀⠙⠳⠤⠤⠤⠴⠛⠀⠀⠀⠀⠙⠶⠤⠄⠀⠀⠿⠀⠀⠀⠀⠈⠓⠦⠤⡤⠴⠞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⠇⠀⠀⠀⠀⠀⠹⠇⠀⠀⠀⠀⠙⠳⠤⠤⠤⠖⠋⠸⠇⠀⠀⠀⠀⠈⣿⠃⠀⠀⠀⠀⠙⠳⠤⠤⠤⠴⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      }
    end

    dashboard.section.header.val = get_header()
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.button(
      "p",
      devicons.get_icon("folder", "lua", { default = true }) .. "  Recent Projects",
      ":Telescope projects<CR>"
    )
    dashboard.section.buttons.val = {
      dashboard.button("e", devicons.get_icon("init.lua", "lua", { default = true }) .. "  New File", ":ene <CR>"),
      dashboard.button(
        "c",
        devicons.get_icon("init.lua", "lua", { default = true }) .. "  Config File",
        ":e $MYVIMRC<CR>"
      ),
      dashboard.button(
        "p",
        devicons.get_icon("nvim", "", { default = true }) .. "  Plugins Folder",
        ":e ~/.config/nvim/lua/kickstart/plugins/<CR>"
      ),
      dashboard.button(
        "f",
        devicons.get_icon("find", "", { default = true }) .. "  Find File",
        ":Telescope find_files<CR>"
      ),
      dashboard.button(
        "r",
        devicons.get_icon("recent", "", { default = true }) .. "  Recent Files",
        ":Telescope oldfiles<CR>"
      ),
      dashboard.button(
        "P",
        devicons.get_icon("folder", "default", { default = true }) .. "  Recent Projects",
        ":Telescope projects<CR>"
      ),

      dashboard.button(
        "s",
        devicons.get_icon("Session.vim", "vim", { default = true }) .. "  Restore Session",
        ":lua require('persistence').load { last = true }<CR>"
      ),
    }

    -- Apply purple highlight
    vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#be95ff", bold = true })
    for _, btn in ipairs(dashboard.section.buttons.val) do
      btn.opts.hl = "AlphaHeader"
    end
    -- Apply purple to header and white to buttons
    vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#be95ff", bold = true })
    vim.api.nvim_set_hl(0, "AlphaWhite", { fg = "#ffffff" })

    dashboard.section.header.opts.hl = "AlphaHeader"
    for _, btn in ipairs(dashboard.section.buttons.val) do
      btn.opts.hl = "AlphaWhite"
    end
    alpha.setup(dashboard.opts)

    -- Refresh header clock every second
    local function get_footer()
      return { os.date " %A, %d %B %Y    %H:%M:%S" }
    end
    local timer = vim.loop.new_timer()
    timer:start(
      1000,
      1000,
      vim.schedule_wrap(function()
        dashboard.section.footer.val = get_footer()
        alpha.redraw()
      end)
    )
  end,
}
