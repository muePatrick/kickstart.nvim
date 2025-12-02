return {
  {
    'milanglacier/minuet-ai.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('minuet').setup {
        virtualtext = {
          auto_trigger_ft = { '*' },
          keymap = {
            accept = '<F2>',      -- accept whole completion
            accept_line = '<F3>', -- accept one line
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            -- accept_n_lines = '<A-z>',
            prev = '<F5>', -- Cycle to prev completion item, or manually invoke completion
            next = '<F4>', -- Cycle to next completion item, or manually invoke completion
            -- dismiss = '<A-e>',
          },
        },
        provider = 'codestral',
        provider_options = {
          codestral = {
            model = 'codestral-latest',
            -- end_point = 'https://codestral.mistral.ai/v1/fim/completions',
            end_point = 'https://api.mistral.ai/v1/fim/completions',
            -- api_key = 'CODESTRAL_API_KEY',
            api_key = function() return 'FHhqlqYe0V2BXq8D3DhBR671VN5CQzCC' end,
            optional = {
              max_tokens = 256,
              stop = { '\n\n' },
            },
          },
        },
        throttle = 1000, -- only send the request every x milliseconds, use 0 to disable throttle.
        debounce = 900,  -- debounce the request in x milliseconds, set to 0 to disable debounce
      }

      -- Create an autocommand group for Minuet events
      local minuet_group = vim.api.nvim_create_augroup("MinuetStatus", { clear = true })

      -- Listen for the MinuetRequestStartedPre event
      vim.api.nvim_create_autocmd("User", {
        pattern = "MinuetRequestStartedPre",
        group = minuet_group,
        callback = function(event)
          local data = event.data
          vim.g.minuet_status = {
            provider = data.provider,
            name = data.name,
            model = data.model,
            n_requests = data.n_requests,
            timestamp = data.timestamp,
            processing = false
          }
        end
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MinuetRequestStarted",
        group = minuet_group,
        callback = function()
          if vim.g.minuet_status then
            vim.g.minuet_status.processing = true
          end
        end
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MinuetRequestFinished",
        group = minuet_group,
        callback = function()
          if vim.g.minuet_status then
            vim.g.minuet_status.processing = false
          end
        end
      })
    end,
  },
}
