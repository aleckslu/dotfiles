-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Windows Clear Shada Temp Files
-- https://github.com/neovim/neovim/issues/8587#issuecomment-2176941108

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  -- pattern = obs_note_pattern,
  callback = function()
    vim.opt_local.wrap = false
    -- vim.opt_local.concealcursor = "c"
    vim.opt_local.spell = false
    vim.opt_local.conceallevel = 2
    -- obs_daily_vault_path
  end,
})

if IsWindows then
  local function clear_shada()
    local shada_path = vim.fn.expand(vim.fn.stdpath("data") .. "/shada")
    local files = vim.fn.glob(shada_path .. "/*", false, true)
    local all_success = 0
    for _, file in ipairs(files) do
      local file_name = vim.fn.fnamemodify(file, ":t")
      if file_name == "main.shada" then
        -- skip your main.shada file
        goto continue
      end
      local success = vim.fn.delete(file)
      all_success = all_success + success
      if success ~= 0 then
        vim.notify("Couldn't delete file '" .. file_name .. "'", vim.log.levels.WARN)
      end
      ::continue::
    end
    if all_success == 0 then
      vim.print("Successfully deleted all temporary shada files")
    end
  end

  vim.api.nvim_create_user_command("ClearShada", clear_shada, { desc = "Clears all the .tmp shada files" })

  vim.api.nvim_create_autocmd("VimLeave", {
    callback = clear_shada,
    desc = "Clear tmp shada files after shada saved",
  })
end

if not IsWindows then
  -- WSL Clipboard
  -- -- sync with system clipboard on focus
  vim.api.nvim_create_autocmd({ "FocusGained" }, {
    pattern = { "*" },
    command = [[call setreg("@", getreg("+"))]],
  })

  --   -- sync with system clipboard on focus
  --   vim.api.nvim_create_autocmd({ "FocusLost" }, {
  --     pattern = { "*" },
  --     command = [[call setreg("+", getreg("@"))]],
  --   })
  --
end
