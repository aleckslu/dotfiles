return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>fe", false },
      {
        "<leader>e",
        -- "<Cmd>Neotree toggle<CR>",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      { "<leader>fE", false },
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },
      window = {
        mappings = {
          ["-"] = "close_node",
        },
      },
    },
  },

  -- CUSTOM: OIL.NVIM
  {
    "stevearc/oil.nvim",
    keys = {
      {
        "<leader>fe",
        function()
          return require("oil").toggle_float()
        end,
        desc = "Oil Float",
      },
    },

    opts = {
      default_file_explorer = false,
      columns = {
        "icon",
      },
      delete_to_trash = true,
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<leader>yf"] = {
          function()
            local file = require("oil").get_cursor_entry()
            if not file then
              return
            end
            local path = require("oil").get_current_dir() .. (file.type == "file" and file.parsed_name or "")
            vim.fn.setreg("+", path)
            print("Yanked oil filepath to @+ : " .. path)
          end,
          desc = "Oil [F]ilename",
        },
        ["<leader>yd"] = {
          function()
            local dir = require("oil").get_current_dir()
            vim.fn.setreg("+", dir)
            print("Yanked oil filepath to @+ : " .. dir)
          end,
          desc = "Cur Oil [D]ir",
        },
        ["q"] = {
          "actions.close",
          buffer = true,
        },
      },
      float = {
        padding = 6,
        max_width = 60,
        max_height = 30,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },
    },

    dependencies = { "echasnovski/mini.icons" },
  },
  -- which-key.nvim
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {
          { "<leader>ub", hidden = true },
          { "<leader>ul", hidden = true },
          { "<leader>uL", hidden = true },
          { "<leader>q", hidden = true },
          { "<F13>", mode = { "i", "c", "t", "v" }, hidden = true },
        },
      },
    },
  },

  -- EXTRA: telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>:", false },
      { "<leader>;", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      {
        "<leader>fC",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
  },

  -- grug-farr.nvim
  -- gitsigns.nvim
  -- trouble.nvim
  -- todo-comments.nvim
  -- flash.nvim -- disabled
}
