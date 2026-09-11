-- Toggleterm：可切换（toggle）的浮动 / 分屏终端
--
-- 背景：LazyVim 默认用 snacks.nvim 提供终端，并绑定了
--   <c-/>、<c-_>、<leader>ft、<leader>fT。
-- 这里把终端整体交给 toggleterm。
--
-- 注意：终端键位统一放在 lua/config/keymaps.lua，而不是本文件的 keys 里。
-- 因为 LazyVim 的默认键位是在 VeryLazy 事件时才加载的，插件 spec 里的 keys
-- 会更早设置，随后被 LazyVim 覆盖掉。config/keymaps.lua 则在默认键位之后加载，
-- 所以能可靠地覆盖。
return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = false, -- 小插件，直接加载，便于 keymaps 里直接 require
    opts = {
      -- 新终端的默认方向：float / horizontal / vertical / tab
      direction = "float",

      -- 窗口尺寸：函数形式可按方向返回不同大小
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4)
        end
      end,

      start_in_insert = true, -- 打开后自动进入插入模式
      persist_size = true, -- 记住手动调整过的窗口大小
      persist_mode = true, -- 记住上次是 insert 还是 normal 模式
      close_on_exit = true, -- 终端进程退出后自动关闭
      auto_scroll = true, -- 有新输出时自动滚到底部
      shade_terminals = true, -- 终端底色比编辑器稍暗/稍亮，便于区分

      float_opts = {
        border = "curved", -- single / double / shadow / curved
        winblend = 0, -- 0 = 不透明，数值越大越透明
        title_pos = "center",
      },

      -- 打开终端时设置 buffer 局部键位
      on_open = function(term)
        local buf = term.bufnr
        -- Esc 回到「终端普通模式」，方便滚动、复制、回看历史
        vim.keymap.set("t", "<esc>", [[<c-\><c-n>]], { buffer = buf, desc = "退出终端输入模式" })
        -- 终端普通模式按 q 关闭窗口
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, desc = "关闭终端" })
        -- Ctrl+h/j/k/l 在分屏终端间跳转
        for _, d in ipairs({ "h", "j", "k", "l" }) do
          vim.keymap.set("t", "<c-" .. d .. ">", "<cmd>wincmd " .. d .. "<cr>", { buffer = buf })
        end
      end,

      on_close = function(term)
        local buf = term.bufnr
        pcall(vim.keymap.del, "t", "<esc>", { buffer = buf })
        pcall(vim.keymap.del, "n", "q", { buffer = buf })
        for _, d in ipairs({ "h", "j", "k", "l" }) do
          pcall(vim.keymap.del, "t", "<c-" .. d .. ">", { buffer = buf })
        end
      end,
    },
  },

  -- 在 which-key 里把 <leader>t 注册成一个分组
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>t", group = "Terminal" },
      },
    },
  },
}
