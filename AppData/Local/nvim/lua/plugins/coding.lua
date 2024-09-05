return {
  -- Nvim-CMP
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline", -- for cmdline autocompletion
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.completion.completeopt = vim.o.completeopt
      -- opts.preselect = cmp.PreselectMode.None
      opts.mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
        ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      })

      cmp.setup.cmdline("/", {
        mapping = require("cmp").mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      -- -- `:` cmdline autocompletion setup.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        -- mapping = cmp.mapping.preset.cmdline() {
        --   ['<C-G>'] = cmp.mapping.confirm { select = true },
        -- },
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
        matching = {
          disallow_symbol_nonprefix_matching = false,
          disallow_fuzzy_matching = false,
          disallow_fullfuzzy_matching = true,
          disallow_partial_matching = false,
          disallow_prefix_unmatching = false,
          disallow_partial_fuzzy_matching = false,
        },
      })
      -- return opts
      -- cmp.setup(opts)
    end,
  },

  -- EXTRA: Mini.Surround
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    },
  },

  --EXTRA: Yanky.Nvim
  {
    "gbprod/yanky.nvim",
    -- recommended = true,
    opts = {
      highlight = { timer = 100 },
    },
    keys = {
      -- { "<leader>p", false },
      {
        "<leader>sy",
        function()
          if LazyVim.pick.picker.name == "telescope" then
            require("telescope").extensions.yank_history.yank_history({})
          else
            vim.cmd([[YankyRingHistory]])
          end
        end,
        mode = { "n", "x" },
        desc = "Yank History",
      },
    },
  },
}
