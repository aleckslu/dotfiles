-- bootstrap lazy.nvim, LazyVim and your plugins
_G.IsWindows = vim.fn.has("win32") == 1
require("config.lazy")

-- local function test_reltime(log_str, fn, ...)
--   local start_time = vim.fn.reltime()
--   fn(...)
--   local end_time = vim.fn.reltime(start_time)
--   local elapsed = vim.fn.reltimestr(end_time)
--   return "time elapsed for  " .. log_str .. " : " .. elapsed
-- end
--
-- vim.print(test_reltime("fn.mode()", function()
--   for _ = 1, 1000000 do
--     vim.fn.mode()
--   end
-- end))
--
-- vim.print(test_reltime("api.nvim_get_mode()", function()
--   for _ = 1, 1000000 do
--     vim.api.nvim_get_mode()
--   end
-- end))
