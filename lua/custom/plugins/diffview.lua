return {
  {
    'sindrets/diffview.nvim',
    config = function()
      vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = '[G]it [D]iff View' })
      vim.keymap.set("n", "<leader>gD", ":DiffviewClose<CR>", { desc = '[G]it [D]iff View Close' })
    end,
  }
}
