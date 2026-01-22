return {
  {
    'ravsii/timers.nvim',
    version = "*", -- use latest stable release
    -- See below, empty is fine
    opts = {},
    dependencies = { 'folke/snacks.nvim' },
    config = function()
      require("timers").setup()
      vim.keymap.set('n', '<leader>xt', function()
        local d = require("timers.duration")
        local m = require("timers.manager")
        local t = require("timers.timer")

        local timer_obj = t.new(d.from(30 * 60 * 1000), {
          title = "Think Block 󰧑 ",
          message = "Take some time to work with full concentration.",
          icon = "󰧑",
          on_finish = function()
            vim.schedule(function()
              require("snacks").notifier.notify(
                "The current Think Block is over! Give that brain a rest.",
                "info",
                { style = "compact", timeout = 3000, title = "Think Block 󰧑 " }
              )
            end)
          end,
        })
        local id, cancel = m.start_timer(timer_obj)
        vim.g.think_block_timer_id = id

        vim.schedule(function()
          require("snacks").notifier.notify(
            "A new Think Block was started! Think hard now.",
            "info",
            { style = "compact", timeout = 3000, title = "Think Block 󰧑 " }
          )
        end)
      end, { desc = 'Start [T]hink Block' })

      vim.keymap.set('n', '<leader>x<S-t>', function()
        if vim.g.think_block_timer_id == nil then
          return
        end

        local m = require("timers.manager")
        m.cancel(vim.g.think_block_timer_id)
        vim.g.think_block_timer_id = nil

        vim.schedule(function()
          require("snacks").notifier.notify(
            "The current Think Block was canceled!",
            "warn",
            { style = "compact", timeout = 3000, title = "Think Block 󰧑 " }
          )
        end)
      end, { desc = 'Cancel [T]hink Block' })
    end
  }
}
