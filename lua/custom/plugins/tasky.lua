return {
  {
    "0pama/tasky.nvim",
    dependencies = { 'folke/snacks.nvim' },
    config = function()
      local pressure_timer = function()
        if vim.g.pressure_timer_id ~= nil then
          local m = require("timers.manager")
          m.cancel(vim.g.pressure_timer_id)
          vim.g.pressure_timer_id = nil
        end

        local tasky = require("tasky")
        local status = tasky.status()
        local plain_text = status:gsub("%%#.-#", "") -- Remove highlight groups
            :gsub("%%.-%%", "")                      -- Remove other formatting markers
            :gsub("\27%[%d+;?%d*;?%d*m", "")         -- Remove ANSI color codes

        local minutes = plain_text:match("%((%d+)%)")

        if not minutes then
          vim.schedule(function()
            require("snacks").notifier.notify(
              "No time estimate found in current todo",
              "warn",
              { style = "compact", timeout = 3000, title = "Pressure Timer 󱅝 " }
            )
          end)
          return
        end

        local d = require("timers.duration")
        local m = require("timers.manager")
        local t = require("timers.timer")

        local timer_obj = t.new(d.from(tonumber(minutes) * 60 * 1000), {
          title = "Pressure Timer 󱅝 ",
          message = "Time's up for: " .. plain_text,
          icon = "󱅝",
          on_finish = function()
            vim.schedule(function()
              require("snacks").notifier.notify(
                "Pressure timer failed!",
                "warn",
                { style = "compact", timeout = 3000, title = "Pressure Timer 󱅝 " }
              )
            end)
            require("beepboop").play_audio("pressure_timer")
            vim.g.pressure_timer_id = nil
          end,
        })

        local id, cancel = m.start_timer(timer_obj)
        vim.g.pressure_timer_id = id
      end

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
        pressure_timer()
      end)

      vim.keymap.set('n', '<leader>xp', function()
        pressure_timer()
      end, { desc = 'Start [P]ressure Timer' })

      vim.keymap.set('n', '<leader>x<S-p>', function()
        if vim.g.pressure_timer_id == nil then
          return
        end

        local m = require("timers.manager")
        m.cancel(vim.g.pressure_timer_id)
        vim.g.pressure_timer_id = nil

        vim.schedule(function()
          require("snacks").notifier.notify(
            "The current Pressure Timer was canceled!",
            "info",
            { style = "compact", timeout = 3000, title = "Pressure Timer 󱅝 " }
          )
        end)
      end, { desc = 'Cancel [P]ressure Timer' })
    end
  }
}
