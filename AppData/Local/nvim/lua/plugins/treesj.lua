return {
  "Wansmer/treesj",
  event = "VeryLazy",
  keys = {
    {
      "<leader>j",
      function()
        require("treesj").toggle()
      end,
      desc = "TreeSJ toggle",
    },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
  opts = {
    use_default_keymaps = false,
  },
}
