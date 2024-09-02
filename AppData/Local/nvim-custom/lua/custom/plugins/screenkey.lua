return {
  'NStefan002/screenkey.nvim',
  lazy = false,
  version = '*', -- or branch = "dev", to use the latest commit
  opts = {
    win_opts = {
      height = 1,
      width = 35,
      title = '',
    },
    disable = {
      buftypes = {
        'terminal',
      },
      filetypes = {
        'toggleterm',
      },
      events = true,
    },
    compress_after = 3,
    show_leader = false,
    clear_after = 15,
    group_mappings = true,
    -- filter = function(keys)
    --   return vim
    --     .iter(keys)
    --     :filter(function(k)
    --       return (k.key ~= 'j' and k.key ~= 'k') or k.is_mapping
    --     end)
    --     :totable()
    -- end,
    -- keys = {
    --   ['<TAB>'] = '󰌒',
    --   ['<CR>'] = '󰌑',
    --   ['<ESC>'] = 'Esc',
    --   ['<SPACE>'] = '␣',
    --   ['<BS>'] = '󰌥',
    --   ['<DEL>'] = 'Del',
    --   ['<LEFT>'] = '',
    --   ['<RIGHT>'] = '',
    --   ['<UP>'] = '',
    --   ['<DOWN>'] = '',
    --   ['<HOME>'] = 'Home',
    --   ['<END>'] = 'End',
    --   ['<PAGEUP>'] = 'PgUp',
    --   ['<PAGEDOWN>'] = 'PgDn',
    --   ['<INSERT>'] = 'Ins',
    --   ['<F1>'] = '󱊫',
    --   ['<F2>'] = '󱊬',
    --   ['<F3>'] = '󱊭',
    --   ['<F4>'] = '󱊮',
    --   ['<F5>'] = '󱊯',
    --   ['<F6>'] = '󱊰',
    --   ['<F7>'] = '󱊱',
    --   ['<F8>'] = '󱊲',
    --   ['<F9>'] = '󱊳',
    --   ['<F10>'] = '󱊴',
    --   ['<F11>'] = '󱊵',
    --   ['<F12>'] = '󱊶',
    --   ['CTRL'] = 'Ctrl',
    --   ['ALT'] = 'Alt',
    --   ['SUPER'] = '󰘳',
    --   ['<leader>'] = '<leader>',
    -- },
  },
}
