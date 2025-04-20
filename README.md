```bash
~/.conig/nvim/
├── init.lua               # Neovim入口文件，最重要，从这里加载所有东西
├── lua/
│   ├── config/             # 通用基础配置（比如options、keymaps、autocmd等）
│   │   ├── options.lua
│   │   ├── keymaps.lua
│   │   ├── autocmds.lua
│   │   └── lazy.lua        # lazy.nvim自身初始化设置（比如插件下载目录）
│   │
│   ├── plugins/            # 所有插件的配置
│   │   ├── init.lua        # 插件集合入口，统一加载所有插件
│   │   ├── nvim-tree.lua   # 具体每个插件一个配置文件
│   │   ├── telescope.lua
│   │   ├── lualine.lua
│   │   └── treesitter.lua
│   │
│   ├── utils/              # 小工具函数，比如映射快捷键的封装、检测环境之类
│   │   └── init.lua
│   │
│   └── lsp/                # LSP相关的配置
│       ├── init.lua
│       ├── servers/        # 单独分开每个语言服务器
│       │   ├── lua_ls.lua
│       │   ├── pyright.lua
│       │   └── tsserver.lua
│       └── settings.lua    # 全局lsp配置，比如on_attach、capabilities等
└── README.md               # （可选）给自己/别人看的配置说明文档
```
