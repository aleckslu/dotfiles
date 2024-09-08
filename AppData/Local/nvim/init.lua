-- bootstrap lazy.nvim, LazyVim and your plugins
_G.IsWindows = vim.fn.has("win32") == 1
require("config.lazy")
