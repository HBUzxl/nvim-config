return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')
    
    -- Set header
    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
      "                                                     ",
    }
    
    -- Set menu with enhanced icons
    dashboard.section.buttons.val = {
      dashboard.button("e", "󰈔  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "󰍉  Find file", ":Telescope find_files<CR>"),
      dashboard.button("r", "󰋚  Recently used files", ":Telescope oldfiles<CR>"),
      dashboard.button("g", "󰊄  Find text", ":Telescope live_grep<CR>"),
      dashboard.button("c", "󰒓  Configuration", ":e $MYVIMRC<CR>"),
      dashboard.button("u", "󰚰  Update plugins", ":Lazy update<CR>"),
      dashboard.button("q", "󰩈  Quit Neovim", ":qa<CR>"),
    }

    -- Set footer
    local function footer()
      local version = vim.version()
      local nvim_version = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
      return "Neovim " .. nvim_version
    end
    dashboard.section.footer.val = footer()
    
    -- Customize layout
    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }
    
    -- Customize colors
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"
    dashboard.section.footer.opts.hl = "Type"
    
    alpha.setup(dashboard.opts)
  end
};
