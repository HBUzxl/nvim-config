-- 底部状态栏
return {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,      -- 启用图标
          theme = 'tokyonight',      -- 主题，建议使用你当前的主题
          section_separators = { '', '' },
          component_separators = { '', '' },
          disabled_filetypes = { "NvimTree", "toggleterm", "startify" }, -- 禁用一些界面
        },
        sections = {
          lualine_a = {'mode'},              -- 编辑模式
          lualine_b = {'branch'},            -- git 分支
          lualine_c = {'filename'},          -- 当前文件名
          lualine_x = {'encoding', 'fileformat', 'filetype'},  -- 编码格式、文件类型等
          lualine_y = {'progress'},          -- 显示进度条
          lualine_z = {'location'},          -- 当前光标行列
        },
        extensions = {'fugitive'},           -- 这里可以配置 Git 扩展
      })
    end
  }
  