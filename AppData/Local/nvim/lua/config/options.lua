-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

opt.scrolloff = 5
opt.wrap = true
-- opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
---@diagnostic disable-next-line: param-type-mismatch
opt.spellfile = vim.fs.joinpath(vim.fn.stdpath("config"), "spell/en.utf-8.add")
opt.undolevels = 3000 -- default 1000 | LazyVim default 10000
opt.history = 2000 -- default 10000

-- OPERATING SYSTEM SPECIFIC OPTS
if IsWindows then
  -- NOTE: Windows Opts

  LazyVim.terminal.setup("pwsh")
else
  -- NOTE: WSL Opts

  opt.clipboard = ""
  opt.shell = "zsh"
  -- wsl system clipboard - '+' & '*' registers
  -- vim.g.clipboard = {
  --   name = "WslClipboard",
  --   copy = {
  --     ["+"] = "clip.exe",
  --     ["*"] = "clip.exe",
  --   },
  --   paste = {
  --     ["+"] = 'pwsh.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  --     ["*"] = 'pwsh.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  --   },
  --   cache_enabled = 0,
  -- }
end
