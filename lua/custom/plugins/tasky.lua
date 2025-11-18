return {
  {
    "0pama/tasky.nvim",
    dependencies = { 'folke/snacks.nvim' },
    config = function()
      require("tasky").setup({
        message_timeout = 2000,
        show_remaining = true,
        show_messages = true,
        winbar = { enabled = false },
        store = {
          file_name = ".tasks.json",
          sync_tasks = true
        },
        edit_win_config = {
          width = 100,
          height = 50,
          relative = "editor",
          col = (vim.o.columns / 2) - 50,
          row = (vim.o.lines / 2) - 25,
          style = "minimal",
          border = "single", -- single, double, rounded, solid, shadow
        },
        categories = {
          ticket = {
            icon = "󰅎",
            hl = "Current Ticket Workitems",
            keymaps = {
              add = "<leader>xa",
              edit = "<leader>xe",
              -- done = "<leader>xd",
              -- next = "<leader>xn",
              toggle = "<leader>vx",
              clear = "<leader>x<S-c>",
            },
          },
        },
      })
      vim.keymap.set('n', '<leader>xd', function()
        local tasky = require("tasky")
        tasky.done("ticket")
        local status = tasky.status()
        local plain_text = status:gsub("%%#.-#", "") -- Remove highlight groups
            :gsub("%%.-%%", "")                      -- Remove other formatting markers
            :gsub("\27%[%d+;?%d*;?%d*m", "")         -- Remove ANSI color codes
        vim.schedule(function()
          require("snacks").notifier.notify(
            plain_text,
            "info",
            { style = "compact", timeout = 5000, title = "New Task started" }
          )
        end)
      end)
    end
  }
}
