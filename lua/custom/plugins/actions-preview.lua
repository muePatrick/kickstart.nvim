return {
  "aznhe21/actions-preview.nvim",
  config = function()
    vim.keymap.set('n', '<leader><enter>', require("actions-preview").code_actions, { desc = 'Code Action Menu' })
    require("actions-preview").setup {
      telescope = {
        sorting_strategy = "ascending",
        layout_strategy = "cursor",
        layout_config = {
          height = 14,
        }
      },
    }
  end
}
