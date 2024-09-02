vim.g.base46_cache = vim.fn.stdpath 'data' .. '/base46_cache/'

return {
  { 'nvim-lua/plenary.nvim', lazy = true },
  {
    'NvChad/base46',
    lazy = true,
    build = function()
      require('base46').load_all_highlights()
    end,
    -- init = function()
    --   vim.g.base46_cache = vim.fn.stdpath 'data' .. '/base46_cache/'
    -- end,
    -- config = function() end,
  },

  -- nvchad ui
  {
    'NvChad/ui',
    config = function()
      require 'nvchad'
    end,
  },

  -- dependency for nvchad ui
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    opts = function()
      return { override = require 'nvchad.icons.devicons' }
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. 'devicons')
      require('nvim-web-devicons').setup(opts)
    end,
  },
}
