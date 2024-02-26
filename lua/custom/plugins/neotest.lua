return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
    },
    config = function()
      require("neotest").setup({
        -- your neotest config here
        adapters = {
          require("neotest-go")({
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=60s" }
          })
        },
      })
      vim.keymap.set('n', '<leader>t<enter>', require("neotest").run.run, { desc = '[T]est Run (nearest)' })
      vim.keymap.set('n', '<leader>tp', require("neotest").output_panel.toggle, { desc = '[T]est [P]anel' })
      vim.keymap.set('n', '<leader>ts', require("neotest").summary.toggle, { desc = '[T]est [S]ummary' })
    end,
  }
}
