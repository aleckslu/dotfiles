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
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    cond = function()
      -- NOTE: add env vars to wsl and change the conditional check for environment var existance
      return vim.fn.has("win32") == 1
    end,

    -- KEYMAPS
    -- NOTE:
    -- general conditionals:
    --    - if cur line empty -> place on cur line
    --    - else -> place next line
    --    - INDENTS:
    --        -
    -- time: <general conditionals>
    -- other bullets: <general conditionals>
    --    - if cur line callout or list with no content -> concat with cur line
    --        -> (`- ` or `> ` or `> * ` or `- [*] `)
    --      - if next and prev line callout -> place in callout
    -- callouts: <general conditionals>
    --    - if cur line callout -> separate w/ time
    --
    -- line_is(line_num, or ['prev' || 'cur' || 'next']) => 'list' || 'checkbox' || 'empty'(or null) || 'callout'
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
        enable = true, -- set to false to disable all additional syntax features
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
      -- ui = { enable = false },
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

      -- vim.api.nvim_create_autocmd("FileType", {
      --   pattern = "markdown",
      --   -- pattern = obs_note_pattern,
      --   callback = function(e)
      --     -- obs_daily_vault_path
      --     -- vim.print(e.buf)
      --     -- vim.bo[e.buf].textwidth = 170
      --     vim.bo[e.buf].conceallevel = 2
      --     -- vim.print(vim.bo[e.buf].textwidth)
      --   end,
      -- })

      require("obsidian").setup(opts)
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- Markdown-Preview
  {
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

  -- [[ MARKVIEW.NVIM ]]
  {
    "OXY2DEV/markview.nvim",
    lazy = true, -- Recommended lazy = false
    ft = "markdown", -- if you decide to lazy load
    opts = {
      checkboxes = {
        enable = false,
      },
      list_items = {
        enable = false,
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      { "nvim-tree/nvim-web-devicons", lazy = true },
      -- "echasnovski/mini.icons",
    },
  },
}
