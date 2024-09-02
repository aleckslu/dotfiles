-- Lua
return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  keys = {
    -- load the session for the current directory
    {
      '<leader>wL',
      function()
        require('persistence').load()
      end,
      desc = '[L]oad Pwd',
    },
    -- select a session to load
    {
      '<leader>ws',
      function()
        require('persistence').select()
      end,
      desc = '[S]earch',
    },
    -- load the last session
    {
      '<leader>wl',
      function()
        require('persistence').load { last = true }
      end,
      desc = '[L]oad Last Session',
    },
    -- stop Persistence => session won't be saved on exit
    {
      '<leader>wQ',
      function()
        require('persistence').stop()
      end,
      desc = '[Q] Stop',
    },
  },
  opts = {
    dir = vim.fn.stdpath 'state' .. '/sessions/', -- directory where session files are saved
    -- minimum number of file buffers that need to be open to save
    -- Set to 0 to always save
    need = 2,
    branch = true, -- use git branch to save session
  },
}
