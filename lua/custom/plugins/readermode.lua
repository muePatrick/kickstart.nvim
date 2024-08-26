return {
  {
    'sarrisv/readermode.nvim',
    opts = {
      enabled = false,
      keymap = "<C-z>",
    },
    config = function()
      vim.keymap.set("n", "<C-z>", ":ReaderMode<CR>", { desc = '[Z]en like readermode' })
    end,
  }
}
