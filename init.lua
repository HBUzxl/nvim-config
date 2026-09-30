-- 在加载任何插件之前，先把 cwd 切到该目录参数。
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)
    if arg ~= "" then
      local path = vim.fn.expand(arg)
      if vim.fn.isdirectory(path) == 1 then
        vim.api.nvim_set_current_dir(path)
      end
    end
  end,
})
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
