return {
  {
    'sindrets/diffview.nvim',
    config = function()
      -- vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = '[G]it [D]iff View' })
      -- vim.keymap.set("n", "<leader>gD", ":DiffviewClose<CR>", { desc = '[G]it [D]iff View Close' })

      vim.keymap.set("n", "<leader>gd",
        function()
          local diffview_exists = false
          for i = 1, vim.fn.tabpagenr('$') do
            local buflist = vim.fn.tabpagebuflist(i)
            for _, bufnr in ipairs(buflist) do
              if vim.fn.bufname(bufnr):match('^diffview://') then
                diffview_exists = true
                break
              end
            end
            if diffview_exists then break end
          end
          
          if diffview_exists then
            vim.cmd('DiffviewClose')
          else
            vim.cmd('DiffviewOpen')
          end
        end, 
        { desc = '[G]it [D]iff View Toggle' }
      )      
    end,
  }
}
