return {
  {
    'AckslD/nvim-neoclip.lua',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('neoclip').setup()
      vim.keymap.set('n', '<S-p>', ':Telescope neoclip<CR>', { desc = 'Open yank history' })
    end,
  },
}
