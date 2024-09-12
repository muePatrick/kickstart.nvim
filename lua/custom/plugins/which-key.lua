-- Useful plugin to show you pending keybinds.
return {
  'folke/which-key.nvim',
  opts = {},
  config = function()
    require("which-key").setup({
      icons = {
        group = "",    -- do not add additional icons to groups, all icons are manually defined
        rules = false, -- do not automatically add icons to mappings
        separator = "",
        breadcrumb = "",
      }
    })
    require("which-key").add({ -- group icons
      { "<leader>a", group = "[A]I",            icon = { icon = "󱜙", color = "yellow" } },
      { "<leader>d", group = "[D]ocumentation", icon = { icon = "󰈙", color = "yellow" } },
      { "<leader>f", group = "[F]ormat",        icon = { icon = "", color = "yellow" }, mode = "n" },
      { "<leader>f", group = "[F]ormat",        icon = { icon = "", color = "yellow" }, mode = "x" },
      { "<leader>g", group = "[G]it",           icon = { icon = "", color = "yellow" } },
      { "<leader>r", group = "[R]andom",        icon = { icon = "󱅕", color = "yellow" } },
      { "<leader>s", group = "[S]earch",        icon = { icon = "", color = "yellow" } },
      { "<leader>t", group = "[T]est",          icon = { icon = "", color = "yellow" } },
      { "<leader>w", group = "[W]orkspace",     icon = { icon = "󰃥", color = "yellow" } },
    })
    require("which-key").add({ -- icons in groups
      { "<leader>ac",       icon = { icon = "󱜹", color = "yellow" } },
      { "<leader>fw",       icon = { icon = "", color = "yellow" } },
      { "<leader>gb",       icon = { icon = "", color = "yellow" } },
      { "<leader>gc",       icon = { icon = "", color = "yellow" } },
      { "<leader>gd",       icon = { icon = "", color = "yellow" } },
      { "<leader>gD",       icon = { icon = "", color = "yellow" } },
      { "<leader>gs",       icon = { icon = "", color = "yellow" } },
      { "<leader>gt",       icon = { icon = "", color = "yellow" } },
      { "<leader>go",       icon = { icon = "", color = "yellow" } },
      { "<leader>ra",       icon = { icon = "", color = "yellow" } },
      { "<leader>rc",       icon = { icon = "", color = "yellow" } },
      { "<leader>rs",       icon = { icon = "", color = "yellow" } },
      { "<leader>ss",       icon = { icon = "󱐋", color = "yellow" } },
      { "<leader>sc",       icon = { icon = "󱣩", color = "yellow" } },
      { "<leader>sd",       icon = { icon = "", color = "yellow" } },
      { "<leader>sf",       icon = { icon = "󰱽", color = "yellow" } },
      { "<leader>sg",       icon = { icon = "", color = "yellow" } },
      { "<leader>sh",       icon = { icon = "󰋖", color = "yellow" } },
      { "<leader>sj",       icon = { icon = "󱈇", color = "yellow" } },
      { "<leader>sm",       icon = { icon = "󱤈", color = "yellow" } },
      { "<leader>so",       icon = { icon = "󰱂", color = "yellow" } },
      { "<leader>st",       icon = { icon = "󱩾", color = "yellow" } },
      { "<leader>sw",       icon = { icon = "", color = "yellow" } },
      { "<leader>sy",       icon = { icon = "󰺯", color = "yellow" } },
      { "<leader>to",       icon = { icon = "", color = "yellow" } },
      { "<leader>ts",       icon = { icon = "", color = "yellow" } },
      { "<leader>t<enter>", icon = { icon = "", color = "yellow" } },
      { "<leader>tt",       icon = { icon = "", color = "yellow" } },
    })
    require("which-key").add({ -- icons on top level (after leader)
      { "<leader>.",       icon = { icon = "󰱺", color = "blue" } },
      { "<leader>l",       icon = { icon = "", color = "blue" } },
      { "<leader>o",       icon = { icon = "󰙅", color = "blue" } },
      { "<leader>p",       icon = { icon = "", color = "blue" } },
      { "<leader>/",       icon = { icon = "", color = "blue" } },
      { "<leader><space>", icon = { icon = "󱦞", color = "blue" } },
      { "<leader><tab>",   icon = { icon = "", color = "blue" } },
      { "<leader><enter>", icon = { icon = "", color = "blue" } },
      { "<leader>q",       icon = { icon = "󰺲", color = "blue" } },
      { "<leader>e",       icon = { icon = "", color = "blue" } },
      { "<leader>R",       icon = { icon = "󰊪", color = "blue" } },
    })
    require("which-key").add({ -- goto icons
      { "gd", icon = { icon = "󱍢", color = "purple" } },
      { "gD", icon = { icon = "󱍢", color = "purple" } },
      { "gI", icon = { icon = "󱍢", color = "purple" } },
      { "gr", icon = { icon = "󱍢", color = "purple" } },
      { "gt", icon = { icon = "󱍢", color = "purple" } },
    })
    require("which-key").add({ -- window icons
      { "<C-w>c", icon = { icon = "󰭌", color = "purple" }, desc = "Close Pane" },
      { "<C-w>C", icon = { icon = "󱘄", color = "purple" } },
      { "<C-w>d", icon = { icon = "", color = "purple" } },
      { "<C-w>D", icon = { icon = "", color = "purple" } },
      { "<C-w>s", icon = { icon = "", color = "purple" },  desc = "Split Window Horizontally" },
      { "<C-w>v", icon = { icon = "", color = "purple" },  desc = "Split Window Ver tically" },
    })
  end,
}
