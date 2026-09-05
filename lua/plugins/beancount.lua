-- .bean 文件也识别为 beancount（.beancount 已默认识别）
vim.filetype.add({
  extension = {
    bean = "beancount",
  },
})

return {
  -- LSP：beancount-language-server
  -- 注意：mason 里的该包需要 cargo 源码编译（本机无 cargo，会安装失败），
  -- 已手动下载预编译版到 ~/.local/bin/beancount-language-server (v1.9.2)。
  -- 设 mason=false 让 LazyVim 直接用 PATH 里的二进制、不经过 mason。
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        beancount = {
          mason = false,
          -- 告诉 LSP 用哪个文件作为账本主文件（含 include 的根文件）。
          -- 否则 LSP 会把当前打开的单文件当成整个账本，从而把
          -- account/*.bean 里已 open 的账户误报为 "unknown account"。
          init_options = {
            journal_file = "main.bean",
          },
        },
      },
    },
  },

  -- Treesitter 语法高亮
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "beancount" })
    end,
  },
}
