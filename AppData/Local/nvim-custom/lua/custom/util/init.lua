local M = {}

local cache = {} ---@type table<(fun()), table<string, any>>
---@generic T: fun()
---@param fn T
---@return T
function M.memoize(fn)
  return function(...)
    local key = vim.inspect { ... }
    cache[fn] = cache[fn] or {}
    if cache[fn][key] == nil then
      cache[fn][key] = fn(...)
    end
    return cache[fn][key]
  end
end

function M.bufdelete(buf)
  buf = buf or 0
  buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

  if vim.bo.modified then
    local choice = vim.fn.confirm(('Save changes to %q?'):format(vim.fn.bufname()), '&Yes\n&No\n&Cancel')
    if choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
      return
    end
    if choice == 1 then -- Yes
      vim.cmd.write()
    end
  end

  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.api.nvim_win_call(win, function()
      if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
        return
      end
      local alt = vim.fn.bufnr '#'
      if alt ~= buf and vim.fn.buflisted(alt) == 1 then
        vim.api.nvim_win_set_buf(win, alt)
        return
      end

      -- Try using previous buffer
      local has_previous = pcall(vim.cmd, 'bprevious')
      if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
        return
      end

      -- Create new listed buffer
      local new_buf = vim.api.nvim_create_buf(true, false)
      vim.api.nvim_win_set_buf(win, new_buf)
    end)
  end
  if vim.api.nvim_buf_is_valid(buf) then
    pcall(vim.cmd, 'bdelete! ' .. buf)
  else
  end
end

function M.find_files_in_favs()
  if vim.env.HOME and vim.env.SEARCH_DIRS and vim.fn.has 'win32' == 1 then
    return require('telescope.builtin').find_files {
      cwd = vim.env.HOME,
      search_dirs = vim.split(vim.env.SEARCH_DIRS, ';', { plain = true }),
      hidden = true,
    }
  end
end

function M.grep_files_in_favs()
  if vim.env.HOME and vim.env.SEARCH_DIRS and vim.fn.has 'win32' == 1 then
    return require('telescope.builtin').live_grep {
      cwd = vim.env.HOME,
      search_dirs = vim.split(vim.env.SEARCH_DIRS, ';', { plain = true }),
      glob_pattern = {
        '!*.git/',
        '!*.aux',
        '!*.fdb_latexmk',
        '!*.fls',
        '!*.log',
        '!*.out',
        '!*.pdf',
        '!*.synctex.gz',
        '!*package-lock.json',
      },
      hidden = true,
    }
  end
end

function M.find_cv_resume()
  if vim.env.RESUME_HOME then
    return require('telescope.builtin').find_files {
      prompt_title = 'Find CV/Resume',
      cwd = vim.env.RESUME_HOME,
      search_file = '*.tex',
    }
  end
end

return M
