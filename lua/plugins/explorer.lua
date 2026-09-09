-- Snacks Explorer 的统一配置
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true, -- 显示 .env、.gitignore 等 dotfiles
          ignored = true, -- 同时显示被 gitignore 忽略的文件
          layout = {
            layout = {
              width = 25,
              min_width = 25,
            },
          },
        },
      },
    },
  },
}
