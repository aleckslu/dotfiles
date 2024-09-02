-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

opt.scrolloff = 7
opt.wrap = true
---@diagnostic disable-next-line: param-type-mismatch
opt.spellfile = vim.fs.joinpath(vim.fn.stdpath("config"), "spell/en.utf-8.add")

-- OPERATING SYSTEM SPECIFIC OPTS
local is_windows = vim.fn.has("win32") == 1
local is_wsl = vim.fn.has("wsl") == 1

if is_windows then
  -- NOTE: Windows Opts

  LazyVim.terminal.setup("pwsh")
elseif is_wsl then
  -- NOTE: WSL Opts

  opt.shell = "zsh"
  -- wsl system clipboard - '+' & '*' registers
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'pwsh.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'pwsh.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end
