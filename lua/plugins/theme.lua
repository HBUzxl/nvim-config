-- 使用 github-nvim-theme 的浅色主题 github_light
return {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function(_, opts)
      require("github-theme").setup(opts)

      local function vscode_light_highlights()
        local groups = {
          Keyword = { fg = "#0000FF" },
          Comment = { fg = "#008000" },
          String = { fg = "#A31515" },
          Number = { fg = "#098658" },
          Function = { fg = "#795E26" },
          Type = { fg = "#267F99" },
          Constant = { fg = "#0000FF" },
          Identifier = { fg = "#001080" },
          ["@keyword"] = { fg = "#0000FF" },
          ["@keyword.control"] = { fg = "#0000FF" },
          ["@comment"] = { fg = "#008000" },
          ["@string"] = { fg = "#A31515" },
          ["@number"] = { fg = "#098658" },
          ["@function"] = { fg = "#795E26" },
          ["@function.call"] = { fg = "#795E26" },
          ["@type"] = { fg = "#267F99" },
          ["@type.builtin"] = { fg = "#267F99" },
          ["@variable"] = { fg = "#001080" },
          ["@variable.parameter"] = { fg = "#001080" },
          ["@constant.builtin"] = { fg = "#0000FF" },
          ["@boolean"] = { fg = "#0000FF" },
        }
        for name, value in pairs(groups) do vim.api.nvim_set_hl(0, name, value) end
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "github_light",
        callback = vscode_light_highlights,
      })
      vim.schedule(vscode_light_highlights)
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_light",
    },
  },
}
