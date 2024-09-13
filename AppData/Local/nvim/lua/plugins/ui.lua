return {
  -- TREESITTER-CONTEXT
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { max_lines = 5 },
  },
  {
    -- https://www.lazyvim.org/plugins/ui#lualinenvim
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      --  
      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }
    end,
  },
}
