return {
  {
    "debugloop/telescope-undo.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      {
        "<S-u>",
        "<cmd>Telescope undo<cr>",
        desc = "Open Undo History",
      },
    },
    opts = {
      -- telescope-undo.nvim config
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup({
        extensions = {
          undo = {
            mappings = {
              i = {
                ["<C-u>"] = require("telescope-undo.actions").restore,
                ["<cr>"] = require("telescope-undo.actions").yank_deletions,
                ["<C-y>"] = require("telescope-undo.actions").yank_additions,
              },
              n = {
                ["u"] = require("telescope-undo.actions").restore,
                ["y"] = require("telescope-undo.actions").yank_deletions,
                ["Y"] = require("telescope-undo.actions").yank_additions,
              },
            },
          },
        },
      })
      require("telescope").load_extension("undo")
    end,
  },
}
