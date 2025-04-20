-- 快捷键设置

vim.g.mapleader = " "     -- 设置<leader>键为空格


local keymap = vim.keymap.set


-- 常用快捷键
keymap("n", "<leader>w", ":w<CR>")     -- 保存
keymap("n", "<leader>q", ":q<CR>")     -- 退出
keymap("n", "<leader>e", ":NvimTreeToggle<CR>") -- 打开nvim-tree
