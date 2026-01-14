return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {},
    config = function()
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-\\>', [[<Cmd>exe v:count1 . "ToggleTerm"<CR>]], opts)
      end

      vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

      local Terminal = require('toggleterm.terminal').Terminal

      local lint_terminal = Terminal:new({
        cmd = "npm run test:lint",
        display_name = "󰱺 Running Lint Test",
        direction = "float",
        close_on_exit = false,
        hidden = true,
        float_opts = {
          border = "curved",
          width = math.floor(vim.o.columns * 0.8),
          height = math.floor(vim.o.lines * 0.8),
          title_pos = 'center',
        }
      })

      local unit_terminal = Terminal:new({
        cmd = "npm run test:unit",
        display_name = " Running Unit Test",
        direction = "float",
        close_on_exit = false,
        hidden = true,
        float_opts = {
          border = "curved",
          width = math.floor(vim.o.columns * 0.8),
          height = math.floor(vim.o.lines * 0.8),
          title_pos = 'center',
        }
      })

      local terminal = Terminal:new({
        display_name = "  Terminal",
        direction = "float",
        close_on_exit = false,
        hidden = true,
        float_opts = {
          border = "curved",
          width = math.floor(vim.o.columns * 0.8),
          height = math.floor(vim.o.lines * 0.8),
          title_pos = 'center',
        }
      })

      local git_terminal = Terminal:new({
        cmd = "git commit",
        display_name = " Git Commit",
        direction = "float",
        close_on_exit = true,
        hidden = true,
        float_opts = {
          border = "curved",
          width = math.floor(vim.o.columns * 0.8),
          height = math.floor(vim.o.lines * 0.8),
          title_pos = 'center',
        }
      })

      vim.keymap.set('n', '<leader>cl', function()
        lint_terminal:toggle()
      end, { desc = '[C]onsole [L]int' })

      vim.keymap.set('n', '<leader>cu', function()
        unit_terminal:toggle()
      end, { desc = '[C]onsole [U]nit tests' })

      vim.keymap.set('n', '<leader>cc', function()
        terminal:toggle()
      end, { desc = '[C]onsole [C]console' })

      vim.keymap.set('n', '<leader>gC', function()
        git_terminal:toggle()
      end, { desc = '[G]it [C]ommit' })
    end
  }
}
