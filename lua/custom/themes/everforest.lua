return {
  'sainnhe/everforest',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.everforest_enable_italic = true
    vim.g.everforest_background = 'soft'        -- `'hard'`, `'medium'`, `'soft'`
    vim.g.everforest_transparent_background = 0 -- 0-2
    vim.g.everforest_dim_inactive_windows = 1
    vim.g.everforest_float_style = 'bright'     -- `'bright'`, `'dim'`
    vim.cmd.colorscheme('everforest')
  end
}
