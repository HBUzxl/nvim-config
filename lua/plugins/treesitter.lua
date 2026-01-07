return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "kotlin", "golang" }, -- LazyVim 会 merge，不是 replace
    },
  },
}
