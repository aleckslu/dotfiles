-- https://www.lazyvim.org/plugins/lsp
return {

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
    opts = {
      ensure_installed = {
        "powershell-editor-services",
        "typescript-language-server",
      },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "powershell",
        "css",
        "jq",
        "sql",
        "latex",
      },
    },
  },
}
