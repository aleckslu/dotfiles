-- https://www.lazyvim.org/plugins/lsp
-- https://www.lazyvim.org/extras/lang/typescript
return {
  -- WARN:
  -- since `vim.tbl_deep_extend`, can only merge tables and not lists,
  --    opts = { ensure_installed = { "tsx", "typescript"} }
  -- would OVERWRITE ensure_installed.  To extend:
  --    opts = function(_, opts)
  --      vim.list_extend(opts.ensure_installed, {
  --        "tsx",
  --        "typescript",
  --      })
  --    end,

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "powershell",
        "css",
        "jq",
        -- "sql",
        -- "latex",
        "tsx",
        "javascript",
        "typescript",
        "query",
        "markdown",
        "markdown_inline",
        "http",
        "scss",
      })
    end,
  },

  -- nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- marksman
        marksman = {},
      },
    },
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "powershell-editor-services",
        "typescript-language-server",
      })
    end,
  },

  -- Debugging
  -- {
  --   "jay-babu/mason-nvim-dap.nvim",
  --   opts = function(_, opts)
  --     vim.list_extend(opts.ensure_installed, {
  --       "js-debug-adapter"
  --     })
  --   end,
  -- },
}
