# Neovim Configuration

这是一个为 Neovim 设计的现代化配置，专注于提供优秀的开发体验。

## 目录结构

```bash
~/.config/nvim/
├── init.lua               # Neovim入口文件，最重要，从这里加载所有东西
├── lua/
│   ├── config/            # 通用基础配置（比如options、keymaps等）
│   │   ├── options.lua
│   │   ├── keymaps.lua
│   │   └── lazy.lua       # lazy.nvim自身初始化设置（比如插件下载目录）
│   │
│   ├── plugins/           # 所有插件的配置
│   │   ├── init.lua       # 插件集合入口，统一加载所有插件
│   │   ├── nvim-tree.lua  # 文件树插件
│   │   ├── telescope.lua  # 模糊搜索插件
│   │   ├── lualine.lua    # 状态栏插件
│   │   ├── treesitter.lua # 语法高亮插件
│   │   ├── bufferline.lua # 标签栏插件
│   │   ├── toggleterm.lua # 终端插件
│   │   ├── completion.lua # 补全插件
│   │   ├── matchup.lua    # 括号匹配插件
│   │   ├── tokyonight.lua # 主题插件
│   │   ├── alpha-nvim.lua # 启动页面插件
│   │   └── which-key.lua  # 快捷键提示插件
│   │
│   └── lsp/               # LSP相关的配置
│       ├── init.lua
│       └── settings.lua   # 全局lsp配置，比如on_attach、capabilities等
└── README.md              # 项目说明文档
```

## 安装说明

1. 确保你已经安装了 Neovim (推荐 v0.9+)
2. 备份你当前的 Neovim 配置（如果有）：
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```
3. 克隆此仓库到你的 Neovim 配置目录：
   ```bash
   git clone https://github.com/HBUzxl/nvim-config.git ~/.config/nvim
   ```
4. 启动 Neovim，lazy.nvim 会自动安装所有插件：
   ```bash
   nvim
   ```

## 插件管理

本配置使用 [lazy.nvim](https://github.com/folke/lazy.nvim) 作为插件管理器。所有插件都在 `lua/plugins/init.lua` 文件中定义。

首次启动 Neovim 时，lazy.nvim 会自动下载并安装所有必需的插件。

## 使用说明

- `<leader>` 键设置为 `\`（反斜杠）
- 使用 `<leader>ff` 打开文件搜索（Telescope）
- 使用 `<leader>fg` 打开内容搜索（Telescope）
- 使用 `<C-n>` 打开文件树（NvimTree）
- 使用 `jk` 进入正常模式（在插入模式下）

更多快捷键可以通过安装后在 Neovim 中使用 `:WhichKey` 查看。