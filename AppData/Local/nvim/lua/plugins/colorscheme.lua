return {
  { -- OnedarkPro
    "olimorris/onedarkpro.nvim",
    name = "onedarkpro",
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
  },

  { -- [[ flow.nvim ]]
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

  { "sho-87/kanagawa-paper.nvim", lazy = true, priority = 1000 },
  { "rebelot/kanagawa.nvim", lazy = true, priority = 1000 },
  { "yorik1984/newpaper.nvim", lazy = true },
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  { "EdenEast/nightfox.nvim", lazy = true },
  { "oxfist/night-owl.nvim", lazy = true },
  { "sainnhe/gruvbox-material", lazy = true },
  { "Mofiqul/dracula.nvim", lazy = true },
  { "neanias/everforest-nvim", version = false, lazy = true },
  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = true },
  { "maxmx03/solarized.nvim", lazy = true },
  { "craftzdog/solarized-osaka.nvim", lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "sainnhe/edge", lazy = true },
  { "sainnhe/sonokai", lazy = true },
  { "ramojus/mellifluous.nvim", lazy = true },
  { "kaiuri/nvim-juliana", lazy = true },
  { "projekt0n/github-nvim-theme", lazy = true },
  { "marko-cerovac/material.nvim", lazy = true },
  { "shaunsingh/nord.nvim", lazy = true },
  { "AlexvZyl/nordic.nvim", lazy = true },
  { "rmehri01/onenord.nvim", lazy = true },
  { "ribru17/bamboo.nvim", lazy = true },
  { "savq/melange-nvim", lazy = true },
  { "maxmx03/fluoromachine.nvim", lazy = true },
  { "eldritch-theme/eldritch.nvim", lazy = true },
  { "HoNamDuong/hybrid.nvim", lazy = true },
  { "rafamadriz/neon", lazy = true },
  { "zootedb0t/citruszest.nvim", lazy = true },
  { "tiagovla/tokyodark.nvim", lazy = true },

  { -- [[ CYBERDREAM ]]
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    opts = {
      transparent = true,
    },
  },

  { -- [[ TOKYONIGHT ]]
    "folke/tokyonight.nvim",
    opts = {
      on_colors = function(c)
        -- colors = https://github.com/folke/tokyonight.nvim/blob/817bb6ffff1b9ce72cdd45d9fcfa8c9cd1ad3839/extras/lua/tokyonight_moon.lua#L1
        c.fg = "#deded7"
      end,
      on_highlights = function(hl, c)
        -- colors = https://github.com/folke/tokyonight.nvim/blob/817bb6ffff1b9ce72cdd45d9fcfa8c9cd1ad3839/extras/lua/tokyonight_moon.lua#L65
        hl["@markup.italic"] = { fg = c.magenta, italic = true }
        hl["@markup.strong"] = { fg = c.yellow, bold = true }
      end,
    },
  },

  { -- LazyVim Setting ColorScheme
    "LazyVim/LazyVim",
    opts = {
      -- Default LazyVim opts: https://www.lazyvim.org/configuration#default-settings
      ---@type string|fun()
      colorscheme = "tokyonight",
    },
  },
}
