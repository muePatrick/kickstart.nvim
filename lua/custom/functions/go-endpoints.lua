function FindGoEndpoints()
  -- Use ripgrep with a more comprehensive pattern and JSON output
  local cmd =
  [[rg "router\.(?:\s*|\n\s*)Handle\((?:\s*|\n\s*)\"([a-zA-Z0-9-\/\{\}]*?)\"(?:(?:\S|[\t ]|\n[^\n])*?Methods\(http\.(\w*))?" -U -g "*.go" --column --json | jq -r 'select(.type == "match") | "\(.data.path.text):\(.data.line_number):\(.data.submatches[0].start):\(.data.submatches[0].match.text | gsub("\\n";" "))"']]

  -- Execute the command and capture the output
  local output = vim.fn.system(cmd)

  -- Split the output into lines
  local lines = vim.split(output, '\n')

  -- Filter out empty lines
  local results = {}
  for _, line in ipairs(lines) do
    if line ~= "" then
      table.insert(results, line)
    end
  end

  -- Create a telescope picker with our results
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local entry_display = require("telescope.pickers.entry_display")

  pickers.new({}, {
    prompt_title = "Go Router Endpoints",
    finder = finders.new_table {
      results = results,
      entry_maker = function(entry)
        -- Parse the ripgrep output format: file:line:column:text
        local file, lnum, col, text = entry:match("([^:]+):(%d+):(%d+):(.*)")
        lnum = tonumber(lnum)
        col = tonumber(col)
        
        -- Extract the URL from the matched text
        local url = text:match('"([^"]*)"')
        
        -- Extract the HTTP method if available
        local http_method = text:match('Methods%(http%.(%w+)')
        local method_name = ""
        if http_method then
          method_name = http_method:gsub("Method", "")
        end
        
        -- Create a displayer with two columns - method and URL
        local max_method_length = 7
        local displayer = entry_display.create {
          separator = " ",
          items = {
            { width = max_method_length + 2 },  -- Method column with padding
            { remaining = true },               -- URL column
          },
        }
        
        local make_display = function()
          local method_hl = "TelescopeResultsNormal"
          
          if method_name == "Get" then
            method_hl = "BlueSign"
          elseif method_name == "Post" then
            method_hl = "GreenSign"
          elseif method_name == "Put" then
            method_hl = "TelescopeResultsOperator"  -- Orange
          elseif method_name == "Delete" then
            method_hl = "Error"                     -- Red
          elseif method_name == "Patch" then
            method_hl = "TelescopeResultsIdentifier" -- Purple
          end
          
          local method_display = method_name ~= "" and (method_name .. ": ") or ""
          
          return displayer {
            { method_display, method_hl },
            { url or text },
          }
        end
        
        return {
          value = entry,
          display = make_display,
          ordinal = (method_name ~= "" and (method_name .. ": ") or "") .. (url or text),
          filename = file,
          path = file,
          lnum = lnum,
          col = col,
          start = lnum,
          finish = lnum
        }
      end
    },
    sorter = conf.generic_sorter({}),
    previewer = conf.qflist_previewer({}),
  }):find()
end

vim.keymap.set('n', '<leader>re', ':lua FindGoEndpoints()<CR>',
  { desc = "Go Router [E]ndpoints", noremap = true, silent = true })
