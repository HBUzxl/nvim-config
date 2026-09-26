-- 1. 文件类型识别（保持全局简洁）
vim.filetype.add({
  extension = {
    bean = "beancount",
  },
})

-- 2. 定义符合 conform.nvim 接口规范的自定义 Formatter
local custom_beancount_formatter = {
  name = "beancount_blank_lines",
  meta = {
    url = "https://beancount.github.io/",
    description = "Insert a blank line between beancount transactions.",
  },
  -- conform 要求实现 format 函数
  format = function(self, ctx, lines, callback)
    -- 非交易类的顶层日期指令，不应该触发补空行
    local non_txn = {
      option = true,
      include = true,
      plugin = true,
      open = true,
      close = true,
      commodity = true,
      balance = true,
      pad = true,
      event = true,
      note = true,
      document = true,
      price = true,
      custom = true,
    }
    ---@param line string
    local function is_transaction(line)
      if not line:match("^%d%d%d%d%-%d%d%-%d%d") then
        return false
      end
      -- 以 * / ! 等符号为 flag 的交易没有字母单词，直接算交易
      local word = line:match("^%d%d%d%d%-%d%d%-%d%d%s+(%a+)")
      return word == nil or not non_txn[word]
    end

    local out = {}
    for i, line in ipairs(lines) do
      if i > 1 and is_transaction(line) and out[#out] ~= "" then
        table.insert(out, "")
      end
      table.insert(out, line)
    end

    -- 返回修改后的 lines 数组，conform 会自动处理 Buffer 替换、光标位置保护及 Undo 树
    callback(nil, out)
  end,
}

return {
  -- 集成到 LazyVim 默认的格式化插件 conform.nvim
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters = opts.formatters or {}
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      -- 注册自定义 Formatter
      opts.formatters.beancount_blank_lines = custom_beancount_formatter

      -- 为 beancount 文件类型配置格式化链：
      -- 先运行自定义补空行，再用 lsp_format = "last" 收尾跑 LSP 对齐。
      -- 注意：conform 没有名为 "lsp" 的 formatter，写 "lsp" 会被静默忽略，
      -- 且因存在 CLI formatter，默认的 lsp_format = "fallback" 会让 LSP 完全不执行，
      -- 结果丢失 currency_column 对齐。必须用 lsp_format = "last"（或 "first"）。
      opts.formatters_by_ft.beancount = { "beancount_blank_lines", lsp_format = "last" }

      return opts
    end,
  },

  -- LSP：beancount-language-server
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        beancount = {
          mason = false,
          init_options = {
            journal_file = "main.bean",
            formatting = {
              currency_column = 50,
            },
          },
        },
      },
    },
  },

  -- Treesitter 语法高亮（安全写法）
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "beancount" })
      end
    end,
  },
}
