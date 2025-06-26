return {
  'tzachar/local-highlight.nvim',
  dependencies = { 'folke/snacks.nvim' },
  config = function()
    require('local-highlight').setup({
      insert_mode = false,
      animate = {
        enabled = true,
        easing = 'inOutCubic',
        duration = {
          step = 10,   -- ms per step
          total = 100, -- maximum duration
        },
      },
    })
  end
}
