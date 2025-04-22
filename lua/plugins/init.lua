-- 插件加载
return {
  require("plugins.nvim-tree"),    -- 文件树
  require("plugins.tokyonight"),   -- 主题
  require("plugins.lualine"),      -- 底部状态栏
  require("plugins.bufferline"),   -- 顶部标签栏
  require("plugins.toggleterm"),   -- 终端标签栏
  require("plugins.completion"),   -- 自动补全
  require("plugins.matchup"),      -- 括号高亮
  require("plugins.treesitter"),   -- 语法高亮/代码解析
  require("plugins.telescope"),    -- 模糊搜索
  require("plugins.alpha-nvim"),   -- 主页
}
