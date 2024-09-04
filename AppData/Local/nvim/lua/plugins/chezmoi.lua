return {
  "xvzc/chezmoi.nvim",
  opts = {
    edit = {
      watch = true,
      force = false,
    },
    notification = {
      on_open = true,
      on_apply = true,
      on_watch = true,
    },
  },
  -- init = function()
  --   -- run chezmoi edit on file enter
  --   vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  --     pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
  --     callback = function()
  --       vim.schedule(require("chezmoi.commands.__edit").watch)
  --     end,
  --   })
  --
  --   -- autoapply on BufWritePost
  --   vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  --     pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
  --     callback = function()
  --       vim.schedule(require("chezmoi.commands.__edit").watch)
  --     end,
  --   })
  --
  --   -- augroup chezmoi
  --   --   autocmd!
  --   --   autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path "%"
  --   --   autocmd BufWritePost /tmp/chezmoi-edit*
  --   --                           \ let fname=fnamemodify(expand("%"), ":s?/tmp/chezmoi-edit[0-9]*/??") |
  --   --                           \ ! chezmoi apply $fname
  --   -- augroup END
  -- end,
}
