return {

  -- Nvim-Notify
  {
    'rcarriga/nvim-notify',
    keys = {
      {
        '<leader>un',
        function()
          require('notify').dismiss { silent = true, pending = true }
        end,
        desc = 'Dismiss All Notifications',
      },
    },
    opts = {
      stages = 'static',
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.6)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.6)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
  },

  -- Noice.nvim
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = false,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
        signature = {
          enabled = false,
        },
      },
      routes = {
        -- disable write messages
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
              { find = '%d more lines' },
            },
          },
          opts = { skip = true },
        },
        -- disable 'written' messages
        {
          filter = {
            event = 'msg_show',
            kind = '',
            find = 'written',
          },
          opts = { skip = true },
        },
        -- disable lsp progress messages
        {
          filter = {
            event = 'lsp',
            kind = 'progress',
            cond = function(msg)
              local client = vim.tbl_get(msg.opts, 'progress', 'client')
              return client == 'lua_ls'
            end,
          },
          opts = { skip = true },
        },
        -- disable search count messages
        {
          filter = {
            event = 'msg_show',
            kind = 'search_count',
          },
          opts = { skip = true },
        },
        -- enable recording @ messages as NOTIFY MSGES
        {
          view = 'notify',
          filter = { event = 'msg_showmode' },
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        -- inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
      'hrsh7th/nvim-cmp',
    },
    keys = {
      {
        '<leader>nh',
        function()
          require('noice').cmd 'history'
        end,
        desc = '[H]istory',
      },
      {
        '<leader>ns',
        function()
          require('noice').cmd 'telescope'
        end,
        desc = '[S]earch Telescope',
      },
      {
        '<leader>nd',
        function()
          require('notify').dismiss { silent = true, pending = true }
        end,
        desc = '[D]ismiss',
        silent = true,
      },
    },
    -- [[ Hide Popup notifications ]]

    config = function(_, opts)
      -- TODO: test to see if i even need this part
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == 'lazy' then
        vim.cmd [[messages clear]]
      end
      -- print(vim.inspect(vim.o.filetype))
      require('noice').setup(opts)

      require('which-key').add {
        { '<leader>n', group = '[N]oice' },
      }
    end,
  },
}
