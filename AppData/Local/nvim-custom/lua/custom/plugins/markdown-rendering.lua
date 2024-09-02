-- Choose either Plugin for Markdown replacement
return {
  -- [[ MARKVIEW.NVIM ]]
  'OXY2DEV/markview.nvim',
  lazy = false, -- Recommended
  -- opts = {},
  config = function()
    -- local markview = require 'markview'
    -- local presets = require 'markview.presets'
    return require('markview').setup {
      -- modes = { 'n', 'no', 'c' },
      -- hybrid_modes = { 'n' },
      -- callbacks = {
      --   on_enable = function(_, win)
      --     vim.wo[win].conceallevel = 2
      --     vim.wo[win].concealcursor = 'c'
      --   end,
      -- },
      -- headings = presets.headings.glow_labels,

      checkboxes = {
        enable = false,
        -- checked = {
        --   text = '',
        --   hl = 'MarkviewCheckboxChecked',
        -- },
        -- unchecked = {
        --   text = '󰄱',
        --   hl = 'MarkviewCheckboxUnchecked',
        -- },
        -- pending = {
        --   text = '',
        --   hl = 'MarkviewCheckboxPending',
        -- },
      },
      list_items = {
        enable = false,
        -- marker_minus = {
        --   -- text = '',
        --   hl = nil,
        -- },
        -- marker_plus = {},
        -- marker_star = {},
        -- marker_dot = {},
      },
    }
  end,
  dependencies = {
    -- You will not need this if you installed the
    -- parsers manually
    -- Or if the parsers are in your $RUNTIMEPATH
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}
