return function()
  local tp_len = #vim.api.nvim_list_tabpages()
  -- TODO: might not need to check if tp_len exists.  there might always be at least one tabpage open
  if tp_len and tp_len < 2 then
    vim.cmd 'tab split '
  else
    vim.cmd 'tabclose $'
  end
end
