-- fcitx5 输入法自动切换（kitty + GNOME Wayland）
--
-- fcitx5-remote 状态语义：
--   无参         1=停用(英文), 2=激活(中文), 0=未运行
--   -c           停用 -> 英文
--   -o           激活 -> 中文
--
-- 注意：本方案依赖 fcitx5 的一个配置——
--   Shift_L 必须放在 [Hotkey/TriggerKeys]，不能放在 [Hotkey/AltTriggerKeys]。
-- 否则 nvim 里调用 fcitx5-remote -c 之后，AltTriggerKey 会被禁用，左 Shift
-- 在其它窗口切不回中文（换新设备时需要手动确认这一条）。

local function fcitx_state()
  local out = vim.trim(vim.fn.system("fcitx5-remote"))
  return tonumber(out) or 0 -- 2=中文激活, 1=英文停用, 0=未运行
end

-- 切到英文；若当时是中文，记下 flag 供下次进入输入模式时恢复
local function to_english()
  if fcitx_state() == 2 then
    vim.b.ime_was_chinese = true
    vim.fn.system("fcitx5-remote -c") -- 停用 -> 英文
  end
end

-- 进入可输入模式时，若上次是从中文离开，则恢复中文
local function restore_chinese()
  if vim.b.ime_was_chinese then
    vim.b.ime_was_chinese = false
    vim.fn.system("fcitx5-remote -o") -- 激活 -> 中文
  end
end

local group = vim.api.nvim_create_augroup("FcitxImeAuto", { clear = true })

-- 离开 insert / 终端 -> 强制英文
vim.api.nvim_create_autocmd({ "InsertLeave", "TermLeave" }, {
  group = group,
  callback = to_english,
})

-- 进入 insert / 终端 -> 按需恢复中文
vim.api.nvim_create_autocmd({ "InsertEnter", "TermEnter" }, {
  group = group,
  callback = restore_chinese,
})

-- 搜索命令行（/ 或 ?）：进入恢复中文、离开强制英文
vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
  group = group,
  pattern = { "/", "?" },
  callback = function(ev)
    if ev.event == "CmdlineEnter" then
      restore_chinese()
    else
      to_english()
    end
  end,
})

-- 重新获得焦点且处于非输入模式时，确保是英文态
vim.api.nvim_create_autocmd("FocusGained", {
  group = group,
  callback = function()
    local m = vim.fn.mode()
    if m == "n" or m:match("^[vV\022sS]") then
      to_english()
    end
  end,
})

return {}
