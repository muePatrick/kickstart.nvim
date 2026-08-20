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

      -- from here is the logic to mark seen files in diffview
      local review_state = {}

      local marks = {
        ["seen"]          = { "󰄭", "Search" },
        ["recheck"]       = { "󰍉", "CurSearch" },
        ["ask-team"]      = { "", "Substitute" },
        ["more-comments"] = { "", "Substitute" },
      }

      local function file_under_cursor()
        local view = require("diffview.lib").get_current_view()
        if not view or not view.panel then return end
        local item = view.panel:get_item_at_cursor()
        if item and item.path then return item end
      end

      local ns = vim.api.nvim_create_namespace("diffview_review_marks")
      vim.api.nvim_set_decoration_provider(ns, {
        on_win = function(_, _, bufnr)
          return vim.bo[bufnr].filetype == "DiffviewFiles"
        end,
        on_line = function(_, _, bufnr, row)
          local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1]
          if not line then return end
          for path, state in pairs(review_state) do
            local name = vim.fn.fnamemodify(path, ":t")
            if line:find(name, 1, true) and marks[state] then
              vim.api.nvim_buf_set_extmark(bufnr, ns, row, 0, {
                virt_text = { { marks[state][1], marks[state][2] } },
                virt_text_pos = "overlay",
                ephemeral = true,
              })
              break
            end
          end
        end,
      })

      local state_order = { "seen", "recheck", "ask-team", "more-comments" }

      local function next_state(current)
        if current == nil then return state_order[1] end
        for i, s in ipairs(state_order) do
          if s == current then
            return state_order[i + 1] -- nil after last -> unset
          end
        end
        return state_order[1] -- unknown state, restart cycle
      end

      local function cycle_mark()
        local file = file_under_cursor()
        if not file then return end
        review_state[file.path] = next_state(review_state[file.path])
        -- persist to your state file here
        vim.cmd("redraw!")
      end

      require("diffview").setup({
        keymaps = {
          file_panel = {
            { "n", "m", cycle_mark, { desc = "Cycle review mark" } },
          },
        },
      })
    end,
  }
}
