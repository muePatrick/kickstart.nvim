return {
  {
    'romgrk/barbar.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    init = function() vim.g.barbar_auto_setup = true end,
    opts = {},
    config = function()
      vim.keymap.set('n', '<C-w>d', ':BufferClose<CR>', { desc = 'Close Buffer (keep window layout)' })
      vim.keymap.set('n', '<C-w><S-d>', ':BufferCloseAllButVisible<CR>', { desc = 'Close All Buffers But Visible' })
    end,
  },
}
