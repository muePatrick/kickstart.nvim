return {
  {
    "stephansama/fzf-nerdfont.nvim",
    lazy = true,
    build = ":FzfNerdfont generate",
    dependencies = { "ibhagwan/fzf-lua" },
    cmd = "FzfNerdfont",
    keys = {
      { "<leader>rn", "<CMD>FzfNerdfont<CR>", desc = "[N]erdfont picker" }
    },
    ---@module 'fzf-nerdfont'
    ---@type FzfNerdFontOpts
    opts = {}
  }
}
