return {
  {
    'codota/tabnine-nvim',
    build = "./dl_binaries.sh",
    config = function()
      require('tabnine').setup({
        disable_auto_comment = true,
        accept_keymap = false,
        dismiss_keymap = "<F3>",
        debounce_ms = 800,
        suggestion_color = { gui = "#808080", cterm = 244 },
        exclude_filetypes = { "TelescopePrompt", "NvimTree" },
        log_file_path = nil, -- absolute path to Tabnine log file
      })
      vim.keymap.set("i", "<F2>", function()
        if require("tabnine.keymaps").has_suggestion() then
          return require("tabnine.keymaps").accept_suggestion()
        else
          return "<CR>"
        end
      end, { expr = true })
      vim.keymap.set("n", "<leader>ac", function()
        if require('tabnine.chat').is_open() then
          require('tabnine.chat').close()
        else
          require('tabnine.chat').open()
        end
      end, { desc = "[C]hat", expr = true })
    end
  },
}
