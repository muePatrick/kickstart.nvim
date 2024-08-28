return {
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({
        use_default_keymaps = false,
      })
      vim.keymap.set('n', '<leader>fw', ':TSJToggle<CR>', {
        desc = 'Toggle code block wrap (objects, arrays, functions, etc.)',
      })
    end,
  },
}
