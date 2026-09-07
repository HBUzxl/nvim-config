-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Clipboard: force OSC 52 provider so yanks reach the LOCAL machine's
-- clipboard (macOS) through herdr's remote bridge, even though this is a
-- headless SSH server with no clipboard tools installed.
-- See :h clipboard-osc52 (Neovim >= 0.10)
if vim.env.SSH_CONNECTION and not vim.env.DISPLAY then
  vim.g.clipboard = "osc52"
  vim.opt.clipboard = "unnamedplus" -- y/p/dd etc. use the system clipboard
end
