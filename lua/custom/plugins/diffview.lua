return {
  {
    'sindrets/diffview.nvim',
    config = function()
      vim.keymap.set("n", "<leader>gm", function()
        local main_branch = vim.fn.system("git main-branch"):gsub("%s+", "")
        vim.cmd("DiffviewOpen " .. main_branch .. "..HEAD --imply-local")
      end, { desc = '[G]it diff to [m]ain' })

      vim.keymap.set("n", "<leader>gM", function()
        local main_branch = vim.fn.system("git main-branch"):gsub("%s+", "")
        vim.cmd("DiffviewFileHistory --range=" .. main_branch .. "..HEAD --imply-local --no-merges --reverse")
      end, { desc = '[G]it file history to [M]ain' })

      -- style the red areas of non-existent code with red diagonal lines
      vim.opt.fillchars:append { diff = "╱" }
      vim.api.nvim_set_hl(0, 'DiffDelete',
        vim.tbl_extend('force',
          vim.api.nvim_get_hl(0, { name = 'DiffDelete' }),
          {
            fg = '#8b6f7d',
            blend = 20,
          }
        )
      )

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
