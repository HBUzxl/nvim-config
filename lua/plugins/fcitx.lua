-- fcitx5-rime 输入法自动切换（kitty + GNOME Wayland）
--
-- 方案：把"中/英"下沉到 Rime 自己的 ascii 模式，fcitx5 始终保持 rime 激活。
--   · 中文 = rime 在线 + 非 ascii；英文 = rime 在线 + ascii
--   · Shift_L 不是 fcitx5 热键，完全交给 Rime（commit_code / 中英切换），
--     所以 Shift_L 在任意窗口都能切，且拼音中按 Shift 会 commit_code
--   · nvim 的 Insert/Normal 自动切换改用 rime 的 DBus 接口 SetAsciiMode
--
-- 依赖：
--   · fcitx5-rime 暴露 org.fcitx.Fcitx.Rime1 @ /rime（SetAsciiMode / IsAsciiMode）
--   · 命令 busctl（systemd 自带）
--   · fcitx5 配置里 Shift_L 不能出现在 TriggerKeys / AltTriggerKeys；
--     Control+space 建议保留作兜底（rime 被停用时重新激活）

local RIME_BUS = "org.fcitx.Fcitx5"
local RIME_PATH = "/rime"
local RIME_IFACE = "org.fcitx.Fcitx.Rime1"
local HAS_BUSCTL = vim.fn.executable("busctl") == 1

-- rime 是否处于英文(ascii)模式
local function rime_is_ascii()
  if not HAS_BUSCTL then
    return false
  end
  local out = vim.fn.system({
    "busctl", "--user", "call", RIME_BUS, RIME_PATH, RIME_IFACE, "IsAsciiMode",
  })
  return out:match("b%s+true") ~= nil
end

-- 设置 rime 的英文(ascii)模式
local function rime_set_ascii(ascii)
  if not HAS_BUSCTL then
    return
  end
  vim.fn.system({
    "busctl", "--user", "call", RIME_BUS, RIME_PATH, RIME_IFACE,
    "SetAsciiMode", "b", ascii and "true" or "false",
  })
end

-- fcitx5 是否激活态（rime 在线）
local function fcitx_active()
  return tonumber(vim.trim(vim.fn.system("fcitx5-remote"))) == 2
end

-- 当前是否"中文"：rime 在线且非 ascii
local function is_chinese()
  return fcitx_active() and not rime_is_ascii()
end

-- 进入非输入模式：切英文，并记住之前是否中文
local function to_english()
  if is_chinese() then
    vim.b.ime_was_chinese = true
  end
  rime_set_ascii(true)
end

-- 进入输入模式：若上次是从中文离开，则恢复中文
local function restore_chinese()
  if vim.b.ime_was_chinese then
    vim.b.ime_was_chinese = false
    if not fcitx_active() then
      vim.fn.system("fcitx5-remote -o") -- rime 被停用时先激活
    end
    rime_set_ascii(false)
  end
end

local group = vim.api.nvim_create_augroup("FcitxImeAuto", { clear = true })

-- 启动即确保非输入模式是英文
vim.api.nvim_create_autocmd("VimEnter", { group = group, callback = to_english })

-- 离开 insert / 终端 -> 英文
vim.api.nvim_create_autocmd({ "InsertLeave", "TermLeave" }, {
  group = group,
  callback = to_english,
})

-- 进入 insert / 终端 -> 按需中文
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
