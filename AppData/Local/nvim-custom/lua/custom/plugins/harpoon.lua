return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {
      --   -- [[ Custom Function Example ]] by Prime: add File with Current Line to harpoon list
      -- cmd = {
      --
      --   -- When you call list:add() this function is called and the return
      --   -- value will be put in the list at the end.
      --   --
      --   -- which means same behavior for prepend except where in the list the
      --   -- return value is added
      --   --
      --   -- @param possible_value string only passed in when you alter the ui manual
      --   add = function(possible_value)
      --     -- get the current line idx
      --     local idx = vim.fn.line '.'
      --
      --     -- read the current line
      --     local cmd = vim.api.nvim_buf_get_lines(0, idx - 1, idx, false)[1]
      --     if cmd == nil then
      --       return nil
      --     end
      --
      --     return {
      --       value = cmd,
      --       -- context = {},
      --     }
      --   end,
      --
      --   --- This function gets invoked with the options being passed in from
      --   --- list:select(index, <...options...>)
      --   --- @param list_item {value: any, context: any}
      --   --- @param list {}
      --   --- @param option any
      --   select = function(list_item, list, option)
      --     -- WOAH, IS THIS HTMX LEVEL XSS ATTACK??
      --     vim.cmd(list_item.value)
      --   end,
      -- },
    }
    local set = vim.keymap.set

    -- [[ basic telescope configuration ]]
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    set('n', '<leader>he', function()
      toggle_telescope(harpoon:list())
    end, { desc = '[H]arpoon S[e]arch' })
    -- [[ end basic telescope config ]]

    -- [[ Basic KEYMAPS ]]
    local harp_add = function()
      harpoon:list():add()
    end

    set('n', '<leader>ha', harp_add, { desc = '[A]dd to Harpoon' })
    set('n', '<leader>m', harp_add, { desc = '[M]ark Harpoon' })

    -- Mapping already used in telescope mapping above
    -- set('n', '<leader>he', function()
    --   harpoon.ui:toggle_quick_menu(harpoon:list())
    -- end)

    set('n', '<leader>hm', function()
      harpoon:list():select(1)
    end, { desc = 'Select [1]' })
    set('n', '<leader>hx', function()
      harpoon:list():select(1)
    end, { desc = 'Select [1]' })

    set('n', '<leader>h,', function()
      harpoon:list():select(2)
    end, { desc = 'Select [2]' })
    set('n', '<leader>hc', function()
      harpoon:list():select(2)
    end, { desc = 'Select [2]' })

    set('n', '<leader>h.', function()
      harpoon:list():select(3)
    end, { desc = 'Select [3]' })
    set('n', '<leader>hv', function()
      harpoon:list():select(3)
    end, { desc = 'Select [3]' })

    set('n', '<leader>hj', function()
      harpoon:list():select(4)
    end, { desc = 'Select [4]' })
    set('n', '<leader>hs', function()
      harpoon:list():select(4)
    end, { desc = 'Select [4]' })

    -- Toggle previous & next buffers stored within Harpoon list
    set('n', '<C-S-H>', function()
      harpoon:list():prev()
    end, { desc = 'Harpoon Prev' })
    set('n', '<C-S-L>', function()
      harpoon:list():next()
    end, { desc = 'Harpoon Next' })

    require('which-key').add {
      { '<leader>h', group = '[H]arpoon' },
    }
  end,
}
