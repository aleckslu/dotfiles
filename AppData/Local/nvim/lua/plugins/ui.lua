return {
  -- TREESITTER-CONTEXT
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { max_lines = 5 },
  },

  -- [[ LUALINE ]]
  {
    -- https://www.lazyvim.org/plugins/ui#lualinenvim
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      --  
      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }
    end,
  },

  -- [[ DASHBOARD ]]
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      opts.config.header = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                                                                       ]],
      }
      opts.config.center = vim.tbl_filter(function(row)
        if row.desc:match("Lazy") then
          return false
        else
          return true
        end
      end, opts.config.center)
    end,
  },
}
