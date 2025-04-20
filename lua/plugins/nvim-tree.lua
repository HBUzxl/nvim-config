return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        update_focused_file = {
            enable = true,
            update_cwd = true,
        },
        renderer = {
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
      })
      -- 如果是直接打开 nvim（没有带文件参数），就自动打开 nvim-tree
        local function open_nvim_tree(data)
        -- 如果打开的是目录才自动开tree
        local directory = vim.fn.isdirectory(data.file) == 1
  
        if not directory then
          return
        end
  
        -- change to the directory
        vim.cmd.cd(data.file)
  
        -- open the tree
        require("nvim-tree.api").tree.open()
      end
  
      vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

    end
  }
  