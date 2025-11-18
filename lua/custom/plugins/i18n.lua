return {
  'yelog/i18n.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('i18n').setup({
      -- Locales to parse; first is the default locale
      -- Use I18nNextLocale command to switch the default locale in real time
      locales = { 'en', 'de' },
      -- sources can be string or table { pattern = "...", prefix = "..." }
      sources = {
        'src/translations/{locales}/translations.json'
        -- { pattern = "src/locales/lang/{locales}/{module}.ts",            prefix = "{module}." },
        -- { pattern = "src/views/{bu}/locales/lang/{locales}/{module}.ts", prefix = "{bu}.{module}." },
      },
      i18n_keys = { popup_type = 'telescope' },
      show_mode = "origin",
      show_locale_file_eol_usage = false,
    })
  end,
  keys = {
    { "<leader>in", function() I18n.next_locale() end,        desc = "[N]ext locale" },
    { "<leader>it", function() I18n.toggle_translation() end, desc = "[T]oggle overlay" },
    { "<leader>ia", function() I18n.add_key() end,            desc = "[A]dd key" },
  }
}
