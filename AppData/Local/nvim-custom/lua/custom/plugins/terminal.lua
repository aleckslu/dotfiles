return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = true,
  opts = {
    open_mapping = { [[<leader>t]], [[<c-\>]] },
    persist_size = true,
    shading_factor = '-11',
    -- shading_ratio = '-1',
    insert_mappings = false,
    terminal_mappings = false,
  },
}
