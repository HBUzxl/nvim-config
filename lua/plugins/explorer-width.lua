-- 调整左侧文件树 (snacks explorer) 的宽度
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          layout = {
            layout = {
              width = 25, -- 侧边栏宽度(字符数),按需修改
              min_width = 25,
            },
          },
        },
      },
    },
  },
}
