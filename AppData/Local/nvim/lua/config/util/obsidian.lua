-- HACK: Set to true to enable vim.print()
local isDebugging = false
local function p(...)
  if not isDebugging then
    return
  end
  vim.print(...)
end

local M = {}
local cur_daily = _G.cur_daily
-- local allowed_lsps = {
-- marksman = true,
-- markdown_oxide = true,
-- }

-- FIX: doesn't work with fns that expect args
-- wrapper to time performance of multiple funcs
-- function M.time_funcs_callbacks(...)
--   local funcs = { ... }
--   return function()
--     local start = vim.fn.reltime()
--     for _, fn in ipairs(funcs) do
--       fn("# Notes", 0)
--     end
--     local elapsed = vim.fn.reltimestr(vim.fn.reltime(start))
--     return "time elapsed for functions: " .. elapsed
--   end
-- end

-- wrapper to time performance of a singlefunc
-- NOTE: adding closure just creates inaccurate timing
---- local start = vim.fn.reltime()
---- local elapsed = vim.fn.reltimestr(vim.fn.reltime(start))
-- function M.time_func(fn, ...)
--   local start_time = nil
--   local end_time = nil
--   local elapsed_time = nil
--   start_time = vim.fn.reltime()
--   fn(...)
--   end_time = vim.fn.reltime(start_time)
--   elapsed_time = vim.fn.reltimestr(end_time)
--   return "time elapsed for functions: " .. elapsed_time
-- end

-- function M.time_func_callback(fn, ...)
--   local args = { ... }
--   return function()
--     local start = vim.fn.reltime()
--     -- NOTE: unpack will make timing slightly inaccurate
--     fn(unpack(args))
--     local elapsed = vim.fn.reltimestr(vim.fn.reltime(start))
--     return "time elapsed for functions: " .. elapsed
--   end
-- end

-- NOTE : Jump to first empty line after a pattern
function M.search_empty_line_pos(pattern)
  pattern = pattern or ""
  vim.fn.search(pattern, "w")
  return vim.fn.searchpos("^\\s*$", "wc")
end

-- FIX: bad. try this instead:
-- vim.api.nvim_open_win(buffer, true, {
--   relative='win',
--   width=120,
--   height=10,
--   border="single",
--   win = 1001,
--   row = 20,
--   col = 20
--   zindex=zindex,
-- })
-- function M.toggle_list_and_boxes()
--   local line = vim.api.nvim_get_current_line()
--   local indent = line:match("^%s*")
--   line = vim.trim(line)
--
--   if line:sub(1, 6) == "- [ ] " then
--     vim.api.nvim_set_current_line(indent .. "- [x] " .. line:sub(7))
--   elseif line:sub(1, 6) == "- [x] " then
--     vim.api.nvim_set_current_line(indent .. "- " .. line:sub(7))
--   elseif line:sub(1, 2) == "- " and line:sub(3, 3) ~= "[" and line:sub(5, 6) ~= "] " then
--     vim.api.nvim_set_current_line(indent .. "- [ ] " .. line:sub(2))
--   elseif not line:sub(1, 1):match("[<>-]") then
--     vim.api.nvim_set_current_line(indent .. "- " .. line)
--   end
-- end

function M.is_line_callout(line_num, buf)
  buf = buf or 0
  local line = vim.trim(vim.api.nvim_buf_get_lines(buf, line_num - 1, line_num, true)[1])
  if #line > 6 then
    return line:sub(1, 1) == ">"
  else
    return false
  end
end

function M.jump_to_last_cursor_pos()
  if cur_daily.last_cursor_pos and vim.api.nvim_buf_is_loaded(0) then
    vim.api.nvim_win_set_cursor(0, cur_daily.last_cursor_pos)
  end
end

function M.get_indent()
  local current_line = vim.api.nvim_get_current_line()
  return current_line:match("^%s*")
end

-- TODO: add option for opening files
-- obsidian://action?param1=value1&param2=value2
function M.open_obs_uri(vault_name, file_name)
  -- NOTE: currently doesn't work in wsl
  local uri = 'start "" "obsidian://open?vault=' .. vault_name .. (file_name and "name=" .. file_name or "") .. '"'
  p("open_obs_uri - uri: " .. uri)
  if vim.fn.has("win32") == 1 then
    os.execute(uri)
  end
end

function M.open_obs_daily()
  local obs_path = require("obsidian").Path.new(cur_daily.path)
  local is_existing = obs_path:is_file()
  if is_existing then
    return vim.cmd(":edit " .. cur_daily.path)
  else
    -- if not cur_daily and cur_daily.date then
    M.open_obs_uri("Personal")
  end
end

function M.get_callout(callout_type, title)
  title = title or ""
  return {
    "> [!" .. callout_type .. "] " .. title,
    "> * ",
  }
end

function M.date_to_sec(date)
  date = date or cur_daily.date
  local year, month, day = date:match("(%d+)-(%d+)-(%d+)")
  return os.time({
    year = tonumber(year),
    month = tonumber(month),
    day = tonumber(day),
    hour = 0,
    min = 0,
    sec = 0,
  })
end

-- function M.get_date_range(start_date, end_date, opts)
--   local default_opts = {
--     to_file_path = false,
--   }
--   opts = vim.tbl_extend("force", default_opts, opts or {})
--   local date_to_sec = M.date_to_sec
--   local start_date_sec = date_to_sec(start_date)
--   local end_date_sec = date_to_sec(end_date) or _G.cur_daily.seconds
--   local os_date = os.date
--   local dates = {}
--   -- get entire path to obsidian note for that date
--   local function get_path(date_sec)
--     return vim.env.OBSIDIAN_PERSONAL_VAULT .. "\\Daily\\" .. os_date("%Y-%m-%d", date_sec) .. "md"
--   end
--   -- get string of date
--   local function get_datestr(date_sec)
--     return os_date("%Y-%m-%d", date_sec)
--   end
--   -- get_str = one of two fns from above to use depending on opts set
--   local get_str = opts.to_file_path or get_path and get_datestr
--   for date_sec = start_date_sec, end_date_sec, 86400 do
--     table.insert(dates, get_str(date_sec))
--   end
--   return dates
-- end

-- TODO:
-- PERFORMANCE: use vim.uv instead
-- function M.collect_sleep_data(pattern, start_date, end_date, opts)
--   local default_opts = {
--     max_range = true,
--   }
--   opts = opts and vim.tbl_extend("force", opts, default_opts) or default_opts
--   local note_list = M.get_date_range(start_date, end_date, { to_file_path = true })
--   local result = {}
--   -- local output = io.open(output_file, 'w')
--   -- if not output then
--   --   vim.notify('Failed to open output file: ' .. output_file, vim.log.levels.ERROR)
--   --   return
--   -- end
--   for _, note_path in ipairs(note_list) do
--     local input = io.open(note_path, "r")
--     if input then
--       for line in input:lines() do
--         if line:match(pattern) then
--           -- output:write(line .. '\n')
--           print("hi")
--         end
--       end
--       input:close()
--     else
--       vim.notify("Failed to open input file: " .. note_path, vim.log.levels.ERROR)
--     end
--   end
--   return result
--   -- output:close()
-- end

-- set & save cursor position on first bufread
-- NOTE: BufRead is the same as BufReadPost
vim.api.nvim_create_autocmd("BufRead", {
  pattern = { "*" .. cur_daily.name },
  once = true,
  callback = function()
    cur_daily.last_cursor_pos = M.search_empty_line_pos("^# Notes")
  end,
})

-- set cursor position on bufread (when buffer is first opened)
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "*" .. cur_daily.name },
  callback = function()
    vim.api.nvim_win_set_cursor(0, cur_daily.last_cursor_pos)
  end,
})

-- get & save cursor pos on bufdelete
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = { "*" .. cur_daily.name },
  callback = function()
    cur_daily.last_cursor_pos = vim.api.nvim_win_get_cursor(0)
  end,
})

-- vim.api.nvim_create_autocmd("LspAttach", {
--   pattern = { vim.env.OBSIDIAN_VAULT_HOME:gsub("\\", "/") .. "/*" },
--   callback = function(e)
--     -- p('obs-utils lsp attach e: ' .. vim.lsp.get_client_by_id(e.data.client_id).name)
--     -- HACK: Obsidian.nvim - Stop LSPs and/or Diagnostics from obsidian vault files
--     -- local obs_pattern = '^' .. vim.fn.expand '~' .. '\\obsidian\\vaults\\.*%.md$'
--     -- allow specific LSPs
--     local obs_client = vim.lsp.get_client_by_id(e.data.client_id)
--     if obs_client and not allowed_lsps[obs_client.name] then
--       -- p('obs_utils STOPPED: ' .. obs_client.name)
--       -- vim.diagnostic.enable(false, { obs_client_ns, id })
--       vim.lsp.stop_client(e.data.client_id)
--     end
--   end,
-- })

return M
