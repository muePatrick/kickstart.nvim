return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    opts = {
      enable_normal_mode_for_inputs = true,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = true,
      },
    },
    config = function()
      vim.keymap.set('n', '<leader>o', ':Neotree toggle<CR>', { desc = 'Open Neotree' })
      vim.keymap.set('n', '<leader>gt', ':Neotree right git_status toggle<CR>', { desc = 'Open [G]it [T]ree' })
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
        },
      })
    end,
  },
}
