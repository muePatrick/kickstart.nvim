return {
  {
    'github/copilot.vim',
    init = function()
      -- turn of automatic mapping of tab-key to accept
      vim.g.copilot_no_tab_map = true
      -- undocumented flag to turn of automatic mapping of any key
      vim.g.copilot_no_maps = true
      -- undocumented flag to assume that an accept key is already mapped
      -- without this copilot does not load if it thinks that no key is mapped
      vim.g.copilot_assume_mapped = true
    end,
    config = function()
      vim.keymap.set('i', '<F2>', 'copilot#Accept("<CR>")', {
        desc = 'Copilot: Accept',
        -- this is here because the doc advises so
        silent = true,
        -- this is here because the command triggered by the hotkey is an
        -- expression
        expr = true,
        -- this is here because the doc advises so
        script = true,
        -- this is here because without it cryptic characters are appended
        -- to the accepted suggestion
        replace_keycodes = false,
      })
      vim.keymap.set('i', '<F3>', 'copilot#Next()', {
        desc = 'Copilot: Accept',
        -- this is here because the doc advises so
        silent = true,
        -- this is here because the command triggered by the hotkey is an
        -- expression
        expr = true,
        -- this is here because the doc advises so
        script = true,
        -- this is here because without it cryptic characters are appended
        -- to the accepted suggestion
        replace_keycodes = false,
      })
      vim.keymap.set('i', '<F4>', 'copilot#Previous()', {
        desc = 'Copilot: Accept',
        -- this is here because the doc advises so
        silent = true,
        -- this is here because the command triggered by the hotkey is an
        -- expression
        expr = true,
        -- this is here because the doc advises so
        script = true,
        -- this is here because without it cryptic characters are appended
        -- to the accepted suggestion
        replace_keycodes = false,
      })
    end,
  },
}
