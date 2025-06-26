return {
  'nvim-treesitter/nvim-treesitter-context',
  config = function()
    -- vim.keymap.set("n", "<S-k>", function()
    --   require("treesitter-context").go_to_context(vim.v.count1)
    -- end, { silent = true, desc = "Jump to context (upwards)" })
  end
  -- FIXME make work for json (e.g. translation files)
}
