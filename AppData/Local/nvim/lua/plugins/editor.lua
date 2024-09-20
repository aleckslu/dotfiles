return {
  {
    -- https://www.lazyvim.org/plugins/editor#neo-treenvim
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
        commands = {
          -- Delete into Recycling Bin using oberblastmeister/trashy cli
          delete = function(state)
            local inputs = require("neo-tree.ui.inputs")
            local path = state.tree:get_node().path
            local msg = "Are you sure you want to delete " .. path
            inputs.confirm(msg, function(confirmed)
              if not confirmed then
                return
              end
              vim.fn.system({
                "trash",
                path,
              })
              require("neo-tree.sources.manager").refresh(state.name)
            end)
          end,
        }, -- Add a custom command or override a global one using the same function name
      },
      window = {
        mappings = {
          ["-"] = "navigate_up",
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
  -- https://www.lazyvim.org/extras/editor/telescope#telescopenvim
  {
    "nvim-telescope/telescope.nvim",
    -- cmd = "Telescope",
    -- version = false,
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
    dependencies = {
      -- dep: telescope-undo, telescope undo, undotree
      {
        "debugloop/telescope-undo.nvim",
        cmd = "Telescope undo",
        keys = {
          { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undo" },
        },
      },
      -- {
      --   -- dep: telescope-fzf-native
      --   "nvim-telescope/telescope-fzf-native.nvim",
      --   build = have_make and "make"
      --     or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      --   enabled = have_make or have_cmake,
      --   config = function(plugin)
      --     LazyVim.on_load("telescope.nvim", function()
      --       local ok, err = pcall(require("telescope").load_extension, "fzf")
      --       if not ok then
      --         local lib = plugin.dir .. "/build/libfzf." .. (LazyVim.is_win() and "dll" or "so")
      --         if not vim.uv.fs_stat(lib) then
      --           LazyVim.warn("`telescope-fzf-native.nvim` not built. Rebuilding...")
      --           require("lazy").build({ plugins = { plugin }, show = false }):wait(function()
      --             LazyVim.info("Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim.")
      --           end)
      --         else
      --           LazyVim.error("Failed to load `telescope-fzf-native.nvim`:\n" .. err)
      --         end
      --       end
      --     end)
      --   end,
      -- },
    },
  },

  -- EXTRA: fzf-lua
  {
    "ibhagwan/fzf-lua",
    enabled = LazyVim.has_extra("editor.fzf"),
    opts = function(_, opts)
      local actions = require("fzf-lua.actions")

      opts.files.actions = {
        ["alt-a"] = { actions.toggle_hidden },
        ["alt-g"] = { actions.toggle_ignore },
      }
      opts.grep.actions = {
        ["alt-a"] = { actions.toggle_hidden },
        ["alt-g"] = { actions.toggle_ignore },
      }
    end,
  },

  -- grug-farr.nvim
  -- gitsigns.nvim
  -- trouble.nvim
  -- todo-comments.nvim
  -- flash.nvim -- disabled
}
