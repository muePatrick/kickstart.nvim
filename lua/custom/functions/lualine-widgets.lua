M = {}

function M.aiStatus()
  if not vim.g.minuet_status then
    return "󱜙"
  elseif not vim.g.minuet_status.name then
    return "󱜙"
  elseif vim.g.minuet_status.processing then
    return "󱜙"
  elseif not vim.g.minuet_status.processing then
    return "󱜙"
  end

  return "󱜙"
end

function M.gitRepository()
  base_dir = vim.fn.system('git rev-parse --show-toplevel')
  -- Remove trailing newline character
  base_dir = base_dir:gsub('\n$', '')

  if base_dir ~= "" then
    return " " .. vim.fn.fnamemodify(base_dir, ':t')
  end
end

function M.gitBranch()
  branch = vim.fn.system('git branch --show-current')
  -- Remove trailing newline character
  branch = branch:gsub('\n$', '')

  if branch ~= "" then
    ticket_project, ticket_number = branch:match("^([A-Z]+)-(%d+)")

    if ticket_project and ticket_number then
      return " " .. ticket_project .. "-" .. ticket_number .. "…"
    else
      return " " .. branch
    end
  end
end

function M.thinkBlockTimer()
  m = require("timers.manager")

  if vim.g.think_block_timer_id == nil then
    return ""
  end

  timer_list = m.timers()
  if timer_list and timer_list[vim.g.think_block_timer_id] then
    expiry = timer_list[vim.g.think_block_timer_id]:expire_in():into_hms()
    return "󰚭 " .. expiry
  else
    return ""
  end
end

function M.currentTaskyTask()
  status = require("tasky").status()

  -- Remove Neovim formatting codes
  -- This pattern matches and removes escape sequences like ^[[38;5;...m
  plain_text = status:gsub("%%#.-#", "") -- Remove highlight groups
      :gsub("%%.-%%", "")                -- Remove other formatting markers
      :gsub("\27%[%d+;?%d*;?%d*m", "")   -- Remove ANSI color codes

  return plain_text
end

return M
