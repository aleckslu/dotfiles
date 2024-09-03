return {
  "folke/persistence.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>qs", false},
    { "<leader>qS", false},
    { "<leader>ql", false},
    { "<leader>qd", false},
    { "<leader>fL", function() require("persistence").load() end, desc = "Load Session (cwd)" },
    { "<leader>fs", function() require("persistence").select() end,desc = "Search Sessions" },
    { "<leader>fl", function() require("persistence").load({ last = true }) end, desc = "Load Last Session" },
    { "<leader>fX", function() require("persistence").stop() end, desc = "Stop Session Save" },
  },
}
