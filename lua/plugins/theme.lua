-- 使用 github-nvim-theme 的浅色主题 github_light
return {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_light",
    },
  },
}
