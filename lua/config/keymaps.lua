-- 自定义键位。LazyVim 会先加载它自己的默认键位（在 VeryLazy 事件），
-- 之后再加载本文件，所以这里可以放心覆盖默认键位。
local map = vim.keymap.set

-- ===================== Toggleterm 终端 =====================

-- 浮动终端：normal / terminal 两种模式都能开关
-- （覆盖 LazyVim 默认的 Snacks 终端键位 <c-/> 和 <c-_>）
map({ "n", "t" }, "<c-/>", "<cmd>ToggleTerm<cr>", { desc = "Terminal (Toggle Float)" })
map({ "n", "t" }, "<c-_>", "<cmd>ToggleTerm<cr>", { desc = "Terminal (Toggle Float)" })

-- 覆盖 LazyVim 默认的 <leader>ft / <leader>fT
-- ft：在项目根目录打开；fT：在当前工作目录打开
map("n", "<leader>ft", function()
  require("toggleterm").toggle(nil, nil, require("lazyvim.util").root(), "float")
end, { desc = "Terminal (Root Dir)" })
map("n", "<leader>fT", function()
  require("toggleterm").toggle(nil, nil, vim.uv.cwd(), "float")
end, { desc = "Terminal (cwd)" })

-- <leader>t 终端分组
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Float" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<cr>", { desc = "Horizontal split" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical size=60<cr>", { desc = "Vertical split" })

-- 编号终端：每个数字对应一个独立终端，可并行开好几个
map("n", "<leader>t1", "<cmd>1ToggleTerm<cr>", { desc = "Terminal 1" })
map("n", "<leader>t2", "<cmd>2ToggleTerm<cr>", { desc = "Terminal 2" })
map("n", "<leader>t3", "<cmd>3ToggleTerm<cr>", { desc = "Terminal 3" })

-- 一次性隐藏 / 显示所有终端
map("n", "<leader>ta", "<cmd>ToggleTermToggleAll<cr>", { desc = "Toggle All" })

-- 把代码发送到终端执行：
--   普通模式 <leader>ts 发送当前行；可视模式 <leader>ts 发送选中内容
map("n", "<leader>ts", "<cmd>ToggleTermSendCurrentLine<cr>", { desc = "Send Line to Terminal" })
map("v", "<leader>ts", "<cmd>ToggleTermSendVisualSelection<cr>", { desc = "Send Selection to Terminal" })
