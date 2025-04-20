return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup {}
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {}) -- 搜索文件
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})  -- 搜索字符串
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})    -- 搜索缓冲区
    end,
  }
