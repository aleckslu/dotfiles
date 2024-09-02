-- File: lua/custom/plugins/filetree.lua

return {
  -- Neotree
  -- {
  --   'nvim-neo-tree/neo-tree.nvim',
  --   version = '*',
  --   keys = { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Toggle Filetree' , silent = true},
  --   cmd = 'Neotree',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
  --     'MunifTanjim/nui.nvim',
  --   },
  --   config = function()
  --     require('neo-tree').setup {
  --       source_selector = {
  --         winbar = false,
  --         statusline = false,
  --       },
  --       window = {
  --         mappings = {
  --           ['P'] = { 'toggle_preview', config = { use_float = false, use_image_nvim = true } },
  --           ['<space>'] = {
  --             'toggle_node',
  --             nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
  --           },
  --         },
  --       },
  --       filesystem = {
  --         filtered_items = {
  --           visible = true, -- when true, they will just be displayed differently than normal items
  --           hide_dotfiles = false,
  --           hide_gitignored = false,
  --           hide_hidden = false, -- only works on Windows for hidden files/directories
  --           hide_by_name = {
  --             --"node_modules"
  --           },
  --         },
  --         follow_current_file = {
  --           enabled = true, -- This will find and focus the file in the active buffer every time
  --           --               -- the current file is changed while the tree is open.
  --           leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
  --         },
  --         group_empty_dirs = true, -- when true, empty folders will be grouped together
  --         hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
  --         -- in whatever position is specified in window.position
  --         -- "open_current",  -- netrw disabled, opening a directory opens within the
  --         -- window like netrw would, regardless of window.position
  --         -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
  --         use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
  --         -- instead of relying on nvim autocmd events.
  --         window = {
  --           mappings = {
  --             ['<bs>'] = 'navigate_up',
  --             ['.'] = 'set_root',
  --             ['H'] = 'toggle_hidden',
  --             ['/'] = 'fuzzy_finder',
  --             ['D'] = 'fuzzy_finder_directory',
  --             ['#'] = 'fuzzy_sorter', -- fuzzy sorting using the fzy algorithm
  --             -- ["D"] = "fuzzy_sorter_directory",
  --             ['f'] = 'filter_on_submit',
  --             ['<c-x>'] = 'clear_filter',
  --             ['[g'] = 'prev_git_modified',
  --             [']g'] = 'next_git_modified',
  --             ['o'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'o' } },
  --             ['oc'] = { 'order_by_created', nowait = false },
  --             ['od'] = { 'order_by_diagnostics', nowait = false },
  --             ['og'] = { 'order_by_git_status', nowait = false },
  --             ['om'] = { 'order_by_modified', nowait = false },
  --             ['on'] = { 'order_by_name', nowait = false },
  --             ['os'] = { 'order_by_size', nowait = false },
  --             ['ot'] = { 'order_by_type', nowait = false },
  --           },
  --           fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
  --             ['<down>'] = 'move_cursor_down',
  --             ['<C-n>'] = 'move_cursor_down',
  --             ['<up>'] = 'move_cursor_up',
  --             ['<C-p>'] = 'move_cursor_up',
  --           },
  --         },
  --         commands = {
  --           -- Delete into Recycling Bin using oberblastmeister/trashy cli
  --           delete = function(state)
  --             local inputs = require 'neo-tree.ui.inputs'
  --             local path = state.tree:get_node().path
  --             local msg = 'Are you sure you wnat to delete ' .. path
  --             inputs.confirm(msg, function(confirmed)
  --               if not confirmed then
  --                 return
  --               end
  --               vim.fn.system {
  --                 'trash',
  --                 path,
  --               }
  --               require('neo-tree.sources.manager').refresh(state.name)
  --             end)
  --           end,
  --         }, -- Add a custom command or override a global one using the same function name
  --       },
  --     }
  --   end,
  -- },

  -- Oil.nvim
  {
    'stevearc/oil.nvim',
    keys = {
      {
        '<leader>e',
        function()
          return require('oil').toggle_float()
        end,
        desc = 'Oil Float',
      },
    },

    opts = {
      default_file_explorer = true,
      columns = {
        'icon',
      },
      delete_to_trash = true,
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['<leader>yf'] = {
          function()
            local file = require('oil').get_cursor_entry()
            if not file then
              return
            end
            local path = require('oil').get_current_dir() .. (file.type == 'file' and file.parsed_name or '')
            vim.fn.setreg('+', path)
            print('Yanked oil filepath to @+ : ' .. path)
          end,
          desc = 'Oil [F]ilename',
        },
        ['<leader>yd'] = {
          function()
            local dir = require('oil').get_current_dir()
            vim.fn.setreg('+', dir)
            print('Yanked oil filepath to @+ : ' .. dir)
          end,
          desc = 'Cur Oil [D]ir',
        },
      },
      float = {
        padding = 6,
        max_width = 60,
        max_height = 30,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
      },
    },

    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
}
