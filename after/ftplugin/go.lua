-- Go 缩进：官方格式 gofmt 使用 tab，而非空格。
-- 这里把缩进宽度从 LazyVim 默认的 2 调整为 4。
-- 注意：设置的是 tab 的宽度，文件里仍然是 tab 字符（不是 4 个空格）。
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = false
