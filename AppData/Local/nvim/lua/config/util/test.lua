---@diagnostic disable: unused-local, unused-function
local M = {}

if LazyVim then
  local LazyVim = LazyVim
else
  vim.notify("LazyVim variable does not exist", vim.log.levels.ERROR)
  return M
end

-- c:\Users\aleck\AppData\Local\nvim-data\lazy\LazyVim\lua\lazyvim\util\init.lua

-- local cache = {} ---@type table<(fun()), table<string, any>>
-- ---@generic T: fun()
-- ---@param fn T
-- ---@return T
-- function M.memoize(fn)
--   return function(...)
--     local key = vim.inspect({ ... })
--     cache[fn] = cache[fn] or {}
--     if cache[fn][key] == nil then
--       cache[fn][key] = fn(...)
--     end
--     return cache[fn][key]
--   end
-- end

-- https://github.com/echasnovski/mini.icons/blob/main/lua/mini/icons.lua#L685
--
-- M.get_all_mini_icons = LazyVim.memoize(function(opts)
function M.get_all_mini_icons(opts)
  local icons = _G.MiniIcons and _G.MiniIcons or require("mini.icons")
  opts = vim.tbl_extend("force", { verbose = false }, opts or {})
  local defaults = icons.list("default")
  local ret = {}
  for _, category in ipairs(defaults) do
    ret[category] = ret[category] or {}
    local icon_names = icons.list(category)
    for _, icon_name in ipairs(icon_names) do
      -- verbose: { icon, hl, is_default}
      local icon_data = opts.verbose and { icons.get(category, icon_name) } or icons.get(category, icon_name)
      ret[category][icon_name] = icon_data
    end
  end
  return ret
end
-- )

return M
