return {
  -- OnedarkPro
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      options = {
        cursorline = true,
        highlight_inactive_windows = true,
        lualine_transparency = true,
        terminal_colors = false,
        -- transparency = true,
      },
      keywords = "italic",
      styles = {
        comments = "italic",
      },
      highlights = {
        CursorLineNr = { fg = "#d19a66", bg = "#2d313b" },
        ["@markup.heading.1.markdown"] = { fg = "#61afef", bg = "#22303d" },
        ["@markup.heading.2.markdown"] = { fg = "#56b6c2", bg = "#203137" },
        ["@markup.heading.3.markdown"] = { fg = "#98c379", bg = "#2a332c" },
        ["@markup.heading.4.markdown"] = { fg = "#e5c07b", bg = "#36322c" },
        ["@markup.heading.5.markdown"] = { fg = "#d19a66", bg = "#362a2b" },
        ["@markup.heading.6.markdown"] = { fg = "#e06c75", bg = "#35262b" },
      },
      colors = {
        onedark = {
          git_add = "#78d173",
          git_change = "#e5c07b",
          git_delete = "#d56c75",
        },
      },
    },
    -- config = function(_,opts)
    -- end,
  },

  -- flow.nvim
  {
    "0xstepit/flow.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      dark_theme = true, -- Set the theme with dark background.
      high_contrast = true, -- Make the dark background darker or the light background lighter.
      transparent = true, -- Set transparent background.
      fluo_color = "orange", -- Color used as fluo. Available values are pink, yellow, orange, or green.
      mode = "normal", -- Mode of the colors. Available values are: dark, bright, desaturate, or base.
      aggressive_spell = false, -- Use colors for spell check.
    },
  },

  -- { "sainnhe/edge" },

  {
    "LazyVim/LazyVim",
    opts = {
      -- Default LazyVim opts: https://www.lazyvim.org/configuration#default-settings
      -- colorscheme can be a string like `catppuccin` or a function that will load the colorscheme
      ---@type string|fun()
      -- colorscheme = function()
      --   require("flow").load()
      -- end,
      colorscheme = "onedark",
    },
  },
}

-- highlight                = "#e2be7d"
-- git_delete               = "#9a353d"
-- black                    = "#282c34"
-- git_change               = "#948B60"
-- color_column             = "#2d313b"
-- git_add                  = "#109868"
-- indentline               = "#3b4048"
-- purple                   = "#c678dd"
-- line_number              = "#495162"
-- comment                  = "#7f848e"
-- inlay_hint               = "#4c525c"
-- fg                       = "#abb2bf"
-- orange                   = "#d19a66"
-- white                    = "#abb2bf"
-- red                      = "#e06c75"
-- gray                     = "#5c6370"
-- cursorline               = "#2d313b"
-- selection                = "#414858"
-- virtual_text_hint        = "#7ec7d1"
-- float_bg                 = "#21252b"
-- fg_gutter_inactive       = "#abb2bf"
-- git_hunk_add             = "#43554d"
-- blue                     = "#61afef"
-- virtual_text_information = "#90c7f4"
-- virtual_text_warning     = "#edd2a1"
-- virtual_text_error       = "#e8939a"
-- bg                       = "#282c34"
-- diff_text                = "#005869"
-- fold                     = "#30333d"
-- diff_delete              = "#501b20"
-- diff_add                 = "#003e4a"
-- fg_gutter                = "#3d4350"
-- git_hunk_delete_inline   = "#6f2e2d"
-- green                    = "#98c379"
-- git_hunk_change_inline   = "#41483d"
-- cyan                     = "#56b6c2"
-- git_hunk_add_inline      = "#3f534f"
-- bg_statusline            = "#22262d"
-- git_hunk_delete          = "#502d30"
-- yellow                   = "#e5c07b"
