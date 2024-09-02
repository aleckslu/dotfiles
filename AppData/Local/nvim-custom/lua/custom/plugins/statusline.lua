local vim = vim

local home_dir = vim.env.HOME
local subdir_pattern = '[^/\\]+[/\\]'
local subdir_sliced_pattern = string.rep(subdir_pattern, 2) .. '$'
-- extra dirs to show in lualine aside from the current file + parent dir

-- TODO: cache
--  change name -> prettify_path
--  add param -> path
--  cache the function: util/init.lua -> .memoize()
local get_parent_path = function()
  local full_path = vim.api.nvim_buf_get_name(0)
  return full_path:gsub(home_dir, '~', 1):gsub('[^/\\]+[/\\][^/\\]+$', '', 1):match(subdir_sliced_pattern) or ''
end

local function get_os_icon()
  if vim.fn.has 'win32' == 1 then
    return ''
  elseif vim.fn.has 'wsl' == 1 or vim.fn.has 'linux' == 1 then
    return ''
  elseif vim.fn.has 'darwin' == 1 then
    return ''
  end
end

return {
  -- 'nvim-lualine/lualine.nvim',
  -- event = 'VeryLazy',
  --
  -- -- opts = function()
  -- --   -- local lualine_require = require 'lualine_require'
  -- --   -- lualine_require.require = require
  -- --   local os_icon = get_os_icon()
  -- --   local function get_color(hl_group, opt)
  -- --     opt = vim.tbl_extend('force', {
  -- --       bg = false,
  -- --     }, opt or {})
  -- --     local hl = vim.api.nvim_get_hl(0, { name = hl_group, link = false })
  -- --     local color = opt.bg and hl.bg or hl.fg
  -- --     if hl and color then
  -- --       return string.format('#%06x', color)
  -- --     else
  -- --       vim.print('get_color(' .. hl_group .. '): ', hl)
  -- --       return nil
  -- --     end
  -- --   end
  -- --
  -- --   local comment_fg = get_color 'Comment'
  -- --   -- oranges @comment.warrning .bg, @comment.error .bg, Boolean .fg
  -- --   local modified_fg = get_color('Boolean', { bg = true }) -- orange
  -- --
  -- --   local opts = {
  -- --     options = {
  -- --       icons_enabled = true,
  -- --       theme = 'auto',
  -- --       component_separators = { left = '', right = '' },
  -- --       section_separators = { left = '', right = '' },
  -- --       disabled_filetypes = {
  -- --         statusline = { 'dashboard', 'alpha', 'ministarter' },
  -- --       },
  -- --       ignore_focus = {},
  -- --       -- always_divide_middle = true,
  -- --       globalstatus = true,
  -- --       refresh = {
  -- --         statusline = 1000,
  -- --       },
  -- --     },
  -- --     sections = {
  -- --       lualine_a = { 'mode' },
  -- --       lualine_b = {
  -- --         'branch',
  -- --         'diff',
  -- --       },
  -- --
  -- --       lualine_c = {
  -- --         {
  -- --           'filetype',
  -- --           -- color = 'lualine_c_normal',
  -- --           icon_only = true,
  -- --           separator = '',
  -- --           padding = { left = 1, right = -1 },
  -- --         },
  -- --         {
  -- --           get_parent_path,
  -- --           color = { fg = comment_fg },
  -- --           padding = { left = 0, right = 0 },
  -- --           separator = { left = '' },
  -- --         },
  -- --         {
  -- --           'filename',
  -- --           path = 4,
  -- --           -- shorting_target = 25,
  -- --           color = function()
  -- --             return vim.bo.modified and { fg = modified_fg, gui = 'bold' } or { gui = 'bold' }
  -- --           end,
  -- --           padding = { left = 0, right = 2 },
  -- --         },
  -- --       },
  -- --       lualine_x = {
  -- --         -- {
  -- --         --   function()
  -- --         --     -- HACK: fix for % error
  -- --         --     return require('screenkey').get_keys():gsub('%%', '⁒'):gsub('%s[hjkl](%.%.x%d*)', ''):gsub('%s[hjkl]', ''):sub(-28)
  -- --         --   end,
  -- --         -- },
  -- --         'diagnostics',
  -- --       },
  -- --       lualine_y = {
  -- --         'searchcount',
  -- --
  -- --         {
  -- --           function()
  -- --             return os_icon
  -- --           end,
  -- --         },
  -- --       },
  -- --       lualine_z = {
  -- --         { 'location', separator = ' ', padding = { left = 1, right = 0 } },
  -- --         { 'progress', padding = { left = 0, right = 1 } },
  -- --       },
  -- --     },
  -- --     inactive_sections = {
  -- --       lualine_a = {},
  -- --       lualine_b = {},
  -- --       lualine_c = { 'filename' },
  -- --       lualine_x = { 'location' },
  -- --       lualine_y = {},
  -- --       lualine_z = {},
  -- --     },
  -- --     tabline = {},
  -- --     winbar = {},
  -- --     inactive_winbar = {},
  -- --     extensions = { 'neo-tree', 'lazy', 'oil', 'nvim-dap-ui', 'mason', 'toggleterm', 'trouble' },
  -- --   }
  -- --   return opts
  -- -- end,
  -- dependencies = { 'nvim-tree/nvim-web-devicons' },
}

-- PERFORMANCE: benchmarking gsub:
--
-- local function benchmark_gsub()
--     local str = "This is a test string. " .. ("x"):rep(10000)  -- Create a long string
--     local pattern = "x"  -- Simple pattern for testing
--
--     -- Benchmark string.gsub
--     local start_time = os.clock()
--     for i = 1, 1000 do
--         str:gsub(pattern, "y")
--     end
--     local elapsed_time_string = os.clock() - start_time
--
--     -- Benchmark vim.re.gsub
--     local regex = vim.regex("x")
--     start_time = os.clock()
--     for i = 1, 1000 do
--         regex:gsub(str, function() return "y" end)
--     end
--     local elapsed_time_vim_re = os.clock() - start_time
--
--     print("string.gsub time: ", elapsed_time_string)
--     print("vim.re.gsub time: ", elapsed_time_vim_re)
-- end
--
-- benchmark_gsub()
--
