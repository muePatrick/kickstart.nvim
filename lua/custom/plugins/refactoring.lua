return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("refactoring").setup({
      show_success_message = true,
    })
    vim.keymap.set("x", "<leader>fe", function() require('refactoring').refactor('Extract Function') end, { desc = '[E]xtract into function' })
    vim.keymap.set("x", "<leader>fv", function() require('refactoring').refactor('Extract Variable') end, { desc = 'Extract into [V]ariable' })
  end,
}
