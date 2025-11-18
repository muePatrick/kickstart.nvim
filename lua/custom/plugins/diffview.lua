return {
  {
    'sindrets/diffview.nvim',
    config = function()
      -- function IsDiffviewOpen()
      --   for i in range(1, tabpagenr('$'))
      --     let buflist = tabpagebuflist(i)
      --     for bufnr in buflist
      --       if bufname(bufnr) =~# '^diffview://'
      --         return true
      --       endif
      --     endfor
      --   endfor
      --   return false
      -- end
      vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = '[G]it [D]iff View' })
      vim.keymap.set("n", "<leader>gD", ":DiffviewClose<CR>", { desc = '[G]it [D]iff View Close' })
    end,
  }
}
