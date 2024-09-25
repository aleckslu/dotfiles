local hour_offset = 5 -- hour of day a new "day" starts
local daily_time_sec = os.time() - hour_offset * 3600
local daily_date = os.date("%Y-%m-%d", daily_time_sec)
local daily_name = daily_date .. ".md"
-- local obs_vault_path = os.getenv("OBSIDIAN_PERSONAL_VAULT") or ""
local obs_daily_dir = os.getenv("OBSIDIAN_PERSONAL_VAULT") .. "\\Daily\\"
-- local obs_path = os.getenv("OBSIDIAN_VAULT_HOME") or ""
-- local obs_note_pattern = "^" .. obs_path:gsub([[\]], [[\\]]) .. "*.md$"
_G.cur_daily = {
  date = daily_date,
  name = daily_name,
  path = obs_daily_dir .. daily_name,
  last_cursor_pos = { 21, 0 },
  seconds = daily_time_sec,
}
local cur_daily = _G.cur_daily
local obs_utils = require("config.util.obsidian")

return {
  { -- [[ OBSIDIAN.NVIM ]]
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    cond = IsWindows,
    -- KEYMAPS
    -- <leader>o -> <localleader> ?
    -- NOTE: [ [ CONDITIONALS ] ]:
    --    general conditionals:
    --       - if cur line empty -> place on cur line
    --       - else -> place next line
    --       - INDENTS:
    --           - something
    --    time: <general conditionals>
    --    other bullets: <general conditionals>
    --       - if cur line callout or list with no content -> concat with cur line
    --           -> (`- ` or `> ` or `> * ` or `- [*] `)
    --         - if next and prev line callout -> place in callout
    --    callouts: <general conditionals>
    --       - if cur line callout -> separate w/ time
    -- NOTE: [ [ INSERT MAPS ] ]
    --    time
    --    pot
    --    research
    --    callouts
    --    --
    --    config:
    --    shop:
    -- NOTE: [ [ FUNCTIONS ] ]
    --    line_is(line_num, or ['prev' || 'cur' || 'next']) => 'list' || 'checkbox' || 'empty'(or null) || 'callout'
    --    turn_into() -> example: turn this line: `- something` into this: `- config: something`
    --            - or `- nvim plugin` -> `- 🔍 nvim plugin`
    --    categories:
    --    insert:
    --    turn line into:
    --  NOTE: [ [ OTHER  ] ]
    --  swerve:
    --    - one extra indent
    --    - change to arrow checkbox
    -- NOTE: [[ keymaps ]]
    -- ObsidianTOC

    keys = {
      { "<leader>og", "<CMD>ObsidianSearch<CR>", desc = "[G]rep Notes" },
      { "<leader>oo", "<CMD>ObsidianQuickSwitch<CR>", desc = "[O]pen Note" },
      { "<leader>oE", "<CMD>ObsidianExtractNote<CR>", desc = "[E]xtract Note", ft = "markdown" },
      -- { "<leader>ow", "<CMD>ObsidianWorkspace<CR>", desc = "Change [W]orkspace" },
      {
        "<leader>od",
        function()
          obs_utils.open_obs_daily()
        end,
        desc = "[O]bs [D]aily",
      },
      -- { "<leader>oe", obs_utils.toggle_obs_daily, desc = "Toggl[e] Daily" },
      -- [[ TEXT INSERTS ]]
      -- TODO: add:
      --  - if prev_line and next_line have same number of spaces as indents,
      --    - indent
      --  - if prev_line and next_line are quotes,
      --    - change to quote instead of '- [>]'
      {
        "<leader>ot",
        function()
          local put_type = "l"
          if vim.api.nvim_get_current_line() == "" then
            put_type = "c"
          end
          vim.api.nvim_put({ "- [>] *" .. os.date("%I:%M%p") .. "*" }, put_type, true, true)
        end,
        ft = "markdown",
        desc = "Insert [T]ime",
      },
      {
        "<leader>oT",
        function()
          vim.api.nvim_put({ "- [>] *" .. os.date("%I:%M%p") .. "*" }, "l", false, true)
        end,
        ft = "markdown",
        desc = "Insert [T]ime Above",
      },
      {
        "<leader>oip",
        function()
          local put_type = "l"
          if vim.api.nvim_get_current_line() == "" then
            put_type = "c"
          end
          vim.api.nvim_put({ "- 🚽" }, put_type, true, true)
        end,
        ft = "markdown",
        desc = "[P]ot",
      },
      {
        "<leader>or",
        function()
          local indent = obs_utils.get_indent()
          -- if prev_line is callout
          --- then callout
          --- copy indent(?)
          -- else
          --- bullet
          vim.api.nvim_put({ indent .. "- 🔍: " }, "l", true, true)
          vim.api.nvim_feedkeys("kA", "n", true)
        end,
        ft = "markdown",
        desc = "[R]esearch",
      },
      {
        "<leader>oR",
        function()
          local indent = obs_utils.get_indent()
          vim.api.nvim_put({ indent .. "  - [*] Reward: " }, "l", true, true)
          vim.api.nvim_feedkeys("kA", "n", true)
        end,
        ft = "markdown",
        desc = "[R]eward",
      },
      {
        "<leader>oiS",
        function()
          vim.api.nvim_put(obs_utils.get_callout("danger", "Swerve"), "l", true, true)
          vim.api.nvim_feedkeys("kA", "n", true)
        end,
        ft = "markdown",
        desc = "[S]werve major",
      },
      {
        "<leader>ois",
        function()
          vim.api.nvim_put(obs_utils.get_callout("question", "swerve"), "l", true, true)
          vim.api.nvim_feedkeys("kA", "n", true)
        end,
        ft = "markdown",
        desc = "[s]werve minor",
      },
      {
        "<leader>ok",
        function()
          -- TODO: add conditional to to avoid combining callouts
          -- print('obsidian.lua leaderok cursor pos:', vim.api.nvim_win_get_cursor(0)[1])
          -- local is_line_callout = obs_utils.is_line_callout(vim.api.nvim_win_get_cursor(0)[1], 0)
          -- if is_line_callout then
          --
          -- end
          vim.api.nvim_put(obs_utils.get_callout("Success", "Completed"), "l", true, true)
          vim.api.nvim_feedkeys("kA", "n", true)
        end,
        ft = "markdown",
        desc = "obs [C]ompleted",
      },
      {
        "<leader>oiw",
        function()
          vim.api.nvim_put(obs_utils.get_callout("Warning", ""), "l", true, true)
          vim.api.nvim_feedkeys("kA", "n", true)
          -- vim.api.nvim_put({ '> [!Failure] ' }, 'l', true, false)
          -- vim.api.nvim_feedkeys('A', 'n', true)
        end,
        ft = "markdown",
        desc = "[W]arning",
      },
      {
        "<leader>oin",
        function()
          vim.api.nvim_put(obs_utils.get_callout("Note", ""), "l", true, true)
          vim.api.nvim_feedkeys("kA", "n", true)
        end,
        ft = "markdown",
        desc = "[N]ote",
      },
    },
    opts = {
      -- disable for marview.nvim
      ui = {
        enable = false, -- set to false to disable all additional syntax features
        update_debounce = 500, -- update delay after a text change (in milliseconds)
        max_file_length = 15000, -- disable UI features for files with more than this many lines
        -- Define how various check-boxes are displayed
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "@markup.italic" },
          ["*"] = { char = "✪", hl_group = "MarkviewBlockQuoteOk" },
          -- ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
          -- ['!'] = { char = '', hl_group = 'ObsidianImportant' },
        },
        -- 🌟 🔥 🚀 🏆 💸 ⭐ 🚨 🎯 ⚡ ❌ 📌 🚀 ✧ ✪ ✦ ✵ arrows: ➥   ⤹  ⤷  ⟿   ↪  ↯  ➜  ➔  ➥ brackets: ❴  ❵  ❱  ❯  ❪  ❫
      },
      workspaces = {
        {
          name = "p",
          path = "~/obsidian/vaults/Personal",
        },
      },
      notes_subdir = "Inbox",
      new_notes_location = "notes_subdir",
      referred_link_style = "wiki",
      templates = {
        folder = "_templates",
      },
      daily_notes = {
        folder = "Daily",
        template = "daily-template.md",
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      mappings = {
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        -- ["<leader>oc"] = {
        --   action = function()
        --     return require("obsidian").util.toggle_checkbox()
        --   end,
        --   opts = { buffer = true },
        -- },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
        ["<leader>oy"] = {
          action = function()
            -- if cur_daily.seconds then
            local path = obs_daily_dir .. os.date("%Y-%m-%d", cur_daily.seconds - 86400) .. ".md"
            return vim.cmd("edit " .. path)
            -- end
          end,
          opts = { desc = "open [Y]esterday" },
        },
        ["<leader>oY"] = {
          action = function()
            -- if cur_daily.seconds then
            local path = obs_daily_dir .. os.date("%Y-%m-%d", cur_daily.seconds + 86400) .. ".md"
            return vim.cmd("edit " .. path)
            -- end
          end,
          opts = { desc = "open Tomorrow" },
        },
        -- ['<leader>op'] = {
        --   action = function()
        --     return require('obsidian').util.working_day_before()
        --   end,
        --   opts = { buffer = true, expr = true },
        -- },
        -- ['<cr>on'] = {
        --   action = function()
        --     return require('obsidian').util.working_day_after()
        --   end,
        --   opts = { buffer = true, expr = true },
        -- },
      },
    },
    config = function(_, opts)
      require("which-key").add({
        { "<leader>o", group = "obsidian" },
        { "<leader>oi", group = "insert" },
      })
      -- overrides for catpuccin
      -- vim.api.nvim_set_hl(0, "@markup.italic", { link = "Conditional" })
      -- vim.api.nvim_set_hl(0, "@markup.strong", { link = "rainbow3" })
      -- vim.api.nvim_set_hl(0, "@markup.quote", { link = "rainbow6" })

      -- overrides for onedark
      -- vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { fg = "#88ddff", bold = true })
      -- vim.api.nvim_set_hl(0, "@markup.list.checked", { link = "DiagnosticOk" })
      -- vim.api.nvim_set_hl(0, "RenderMarkdownUnchecked", { link = "Boolean", bold = true })

      require("obsidian").setup(opts)
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  { -- Markdown-Preview
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function()
      require("lazy").load({ plugins = { "markdown-preview.nvim" } })
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },

  { -- [[ MARKVIEW.NVIM ]]
    "OXY2DEV/markview.nvim",
    enabled = false,
    -- enabled = not LazyVim.has_extra("lang.markdown"),
    lazy = true, -- Recommended lazy = false
    ft = "markdown", -- if you decide to lazy load
    opts = {
      checkboxes = {
        enable = false,
      },
      list_items = {
        enable = false,
      },

      -- hybrid mode - https://github.com/OXY2DEV/markview.nvim?tab=readme-ov-file#-hybrid-mode
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      -- { "nvim-tree/nvim-web-devicons", lazy = true },
      -- "echasnovski/mini.icons", -- doesn't work
      "nvim-web-devicons",
    },
  },

  { -- [[ Render-Markdown , Markdown.nvim ]]
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "norg", "rmd", "org" },
    opts = {
      -- [ [ LAZYVIM DEFAULT OPTS ] ]
      file_types = { "markdown", "norg", "rmd", "org" },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },

      -- [ [ CUSTOM OPTS ] ]
      heading = { -- Heading/Headers
        enabled = true,
        sign = true,
        position = "overlay",
        -- icons = { "  " },
        -- icons = { " 󰲡 ", " 󰲣 ", " 󰲥 ", " 󰲧 ", " 󰲩 ", " 󰲫 " },
        -- signs = { "󰫎 " },
        width = "full",
        -- backgrounds = {
        --   "@markup.heading.1.markdown",
        --   "@markup.heading.2.markdown",
        --   "@markup.heading.3.markdown",
        --   "@markup.heading.4.markdown",
        --   "@markup.heading.5.markdown",
        --   "@markup.heading.6.markdown",
        -- },
        -- foregrounds = {
        --   "@markup.heading.1.markdown",
        --   "@markup.heading.2.markdown",
        --   "@markup.heading.3.markdown",
        --   "@markup.heading.4.markdown",
        --   "@markup.heading.5.markdown",
        --   "@markup.heading.6.markdown",
        -- },
      },

      -- • 󰄱   ✪
      -- • ◦ ‣ ⁃ ⁌ ⁍ ∙ ○ ● ◘ ⦾ ⦿ ◉
      -- BULLETS LISTS
      bullet = {
        enabled = true,
        -- Replaces '-'|'+'|'*' of 'list_item'
        -- "‣", "∙"
        icons = { "•", "◦" },
        -- left_pad = 0,
        -- right_pad = 0,
        -- highlight = "RenderMarkdownBullet",
      },

      -- CHECKBOXES
      checkbox = {
        enabled = true,
        -- Determines how icons fill the available space:
        --  inline:  underlying text is concealed resulting in a left aligned icon
        --  overlay: result is left padded with spaces to hide any additional text
        position = "inline",
        unchecked = {
          icon = "󰄱",
          highlight = "RenderMarkdownUnchecked",
        },
        checked = {
          icon = "",
          highlight = "RenderMarkdownChecked",
        },
        custom = {
          -- todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" }, -- this is on by default
          time = { raw = "[>]", rendered = "󰥔", highlight = "@markup.italic.markdown_inline" },
          reward = { raw = "[*]", rendered = "✪", highlight = "DiagnosticOk" },
          warn = { raw = "[!]", rendered = "", highlight = "Error" },
        },
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      LazyVim.toggle.map("<leader>um", {
        name = "Render Markdown",
        get = function()
          return require("render-markdown.state").enabled
        end,
        set = function(enabled)
          local m = require("render-markdown")
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      })
    end,
  },
}
