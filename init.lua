-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text_pos = 'eol',
      },
    },
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        -- theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        -- lualine_a = { 'mode' },
        -- lualine_b = { 'branch', 'diff', 'diagnostics' },
        -- lualine_c = { 'filename' },
        -- lualine_x = { 'encoding', 'fileformat', 'filetype' },
        -- lualine_y = { 'progress' },
        -- lualine_z = { 'location' }
        -- Left side
        lualine_a = {
          'mode',
          require('custom.functions.lualine-widgets').aiStatus,
        },
        lualine_b = { 'filename' },
        lualine_c = {
          require('custom.functions.lualine-widgets').gitRepository,
          require('custom.functions.lualine-widgets').gitBranch,
          'diff',
        },
        -- Right side
        lualine_x = {
          { require('custom.functions.lualine-widgets').thinkBlockTimer,  color = { fg = "#555555", bg = "#79bad2", gui = 'bold' } },
          { require('custom.functions.lualine-widgets').pressureTimer,    color = { fg = "#555555", bg = "#d2d279", gui = 'bold' } },
          { require('custom.functions.lualine-widgets').currentTaskyTask, color = { fg = "#555555", bg = "#d2d279", gui = 'bold' } },
        },
        lualine_y = {},
        lualine_z = { 'progress', 'location' }
      }
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = "ibl",
    opts = {
      indent = {
        highlight = 'IblIndent',
        char = "┊",
      },
      scope = {
        enabled = false,
        char = "┊",
        highlight = { "Function", "Label" },
        show_start = true,
        show_end = true,
      },
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',         opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },

  { import = 'custom.plugins' },
  { import = 'custom.themes' },
}, {})

-- [[ Basic Vim Config ]]
require('custom.functions.vim-config')

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.keymap.set('n', '<leader>p', ':Explore<CR>', { desc = 'Open Explorer' })
-- moving this into the plugin file breaks the plugin
vim.keymap.set('n', '<leader>st', ':TodoTelescope keywords=TODO,FIXME,BUG<CR>', { desc = '[S]earch [T]odo' })
vim.keymap.set('n', '<leader>sr', ':TodoTelescope keywords=RR,R:<CR>', { desc = '[S]earch [R]esearch' })
vim.keymap.set("n", "<leader>sR", function()
  vim.ui.input({ prompt = "Label name: " }, function(input)
    if not input or input == "" then
      return
    end
    local row = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, row, row, false, { "// RR " .. input })
    vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
  end)
end, { desc = '[S]earch [R]esearch: New Label' })

vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = 'Save File' })
vim.keymap.set('n', '<C-w><S-c>', ':bd<CR>', { desc = 'Close Buffer And Pane' })
vim.keymap.set('n', '<C-w>T', ':tabedit %<CR>', { desc = 'Break out into new tab' })
vim.keymap.set('n', '<F5>', ':e<CR>', { desc = 'Reload Buffer' })
vim.keymap.set('n', '<F6>', ':silent bufdo e<CR>', { desc = 'Reload All Buffers' })
vim.keymap.set('n', '<C-p>', 'A<CR><ESC>p', { desc = '[P]aste after newline' })

vim.keymap.set('n', '<leader>vr', ':set relativenumber!<CR>', { desc = 'Toggle [r]elative line numbers' })
vim.keymap.set('n', '<leader>vw', ':set list!<CR>', { desc = 'Toggle [w]hite space indicators' })
vim.keymap.set('n', '<leader>vc', ':TSContext toggle<CR>', { desc = 'Toggle [c]ontext' })
vim.keymap.set('n', '<leader>vd', function()
  local use_virtual_lines = not vim.diagnostic.config().virtual_lines

  vim.diagnostic.config({
    virtual_lines = use_virtual_lines,
    virtual_text = not use_virtual_lines,
  })
end, { desc = 'Toggle diagnostic [v]irtual lines/text' })

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = require('telescope.actions').delete_buffer,
        ['<C-q>'] = require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist,
        ['<C-f>'] = require('telescope.actions').add_selected_to_qflist + require('telescope.actions').open_qflist,
        ['<C-a>'] = require('telescope.actions').select_all,
      },
    },
    -- path_display = { 'absolute', 'smart' },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = 'Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>ss', function() require("flash").jump() end, { desc = '[S]earch Flash' })
vim.keymap.set('n', '<leader>so', function() require('telescope.builtin').oldfiles({ only_cwd = true }) end,
  { desc = '[S]earch [O]ldfiles' })
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').spell_suggest, { desc = '[S]earch [C]orrections' })
vim.keymap.set('n', '<leader>sj', require('telescope.builtin').jumplist, { desc = '[S]earch [J]umps' })
vim.keymap.set('n', '<leader>sm', require('telescope.builtin').marks, { desc = '[S]earch [M]arks' })
vim.keymap.set('n', '<leader>sy',
  function()
    require('telescope.builtin').lsp_document_symbols({
      symbols = {
        "method",
        "function",
        "variable",
        "constant",
      }
    })
  end, { desc = '[S]earch S[y]mbols' })


vim.keymap.set('n', '<leader>gn', ':Gitsigns next_hunk<CR>', { desc = '[G]it [N]ext Hunk' })
vim.keymap.set('n', '<leader>gp', ':Gitsigns prev_hunk<CR>', { desc = '[G]it [P]revious Hunk' })
vim.keymap.set('n', '<leader>ga', ':Gitsigns stage_hunk<CR>', { desc = '[G]it [A]dd' })
vim.keymap.set('v', '<leader>ga', ':Gitsigns stage_hunk<CR>', { desc = '[G]it [A]dd' })
vim.keymap.set('v', '<leader>gd', ':Gitsigns reset_hunk<CR>', { desc = '[G]it [D]iscard' })
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = '[G]it [S]tatus' })
vim.keymap.set('n', '<leader>gc', ':DiffviewFileHistory<CR>', { desc = '[G]it [C]ommits' })
vim.keymap.set('n', '<leader>gb', ':Gitsigns blame<CR>', { desc = '[G]it [b]lame' })
vim.keymap.set('n', '<leader>gB', require('telescope.builtin').git_branches, { desc = '[G]it [B]ranches' })
vim.keymap.set('n', '<leader>go',
  function()
    local command = vim.fn.join({ vim.fn.line('.'), "GBrowse" }, '')
    vim.cmd(command)
  end, { desc = '[G]it [O]pen in browser' })

vim.keymap.set('n', '<leader>rs', ':tabnew<CR>', { desc = '[S]cratch Buffer' })
vim.keymap.set('n', '<leader>ra', require('telescope.builtin').builtin, { desc = 'List Telescope builtins' })
vim.keymap.set('n', '<leader>rt', require('telescope.builtin').colorscheme, { desc = 'List Telescope builtins' })
vim.keymap.set('n', '<leader>rc',
  function()
    local filePathWithCursor = vim.fn.join({ vim.fn.expand("%"), vim.fn.line('.'), vim.fn.col('.') }, ':')
    vim.fn.jobstart({ "code", ".", "-g", filePathWithCursor })
  end, { desc = 'Open in VS [C]ode' })

-- remap shift + up arrow to the function of ctrl + e
vim.keymap.set('n', '<S-Down>', '<C-e>', { desc = 'Scroll up' })
vim.keymap.set('n', '<S-Up>', '<C-y>', { desc = 'Scroll down' })

vim.keymap.set('n', '<tab>', '<C-W>w', { desc = 'Next Window' })
vim.keymap.set('n', '<S-tab>', '<C-W>W', { desc = 'Previous Window' })
vim.keymap.set('n', '<leader><tab>', ':b#<CR>', { desc = 'Toggle last used buffers' })
vim.keymap.set('n', '<C-n>', ':cn<CR>', { desc = '[N]ext item in quickfixlist' })

vim.keymap.set('v', '<leader>fr', function()
  vim.cmd('normal! "zy')
  local selected_text = vim.fn.getreg('z')
  local escaped_text = selected_text:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "\\%1")
  escaped_text = escaped_text:gsub("\n", "\\n")
  local cmd = ":%s/" .. escaped_text .. "//g"
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes(cmd, true, false, true), "n")
  local cursor_position = #cmd - 3
  -- vim.fn.setcmdpos(cursor_position)
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Home>", true, false, true), "n")
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true):rep(cursor_position), "n")
end, { desc = '[R]eplace selection' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  modules = {},         -- TODO had to be set after update, find proper setting
  sync_install = false, -- TODO had to be set after update, find proper setting
  ignore_install = {},  -- TODO had to be set after update, find proper setting
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = {
    'c',
    'cpp',
    'go',
    'lua',
    'python',
    'rust',
    'tsx',
    'typescript',
    'vimdoc',
    'vim',
    'markdown',
    'markdown_inline',
  },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        -- These are available in visual mode (and will also show up in the hotkey preview)
        -- They can also have a description like so:
        -- ['aa'] = { query = "@assignment.outer", desc = "Select [A]round [A]ssignment" },
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        -- ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        -- ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

vim.keymap.set('n', 'ru', function()
  local ts_utils = require 'nvim-treesitter.ts_utils'
  local node = ts_utils.get_node_at_cursor()
  print("Node type:", node:type())
end, { desc = "Node [U]nder cursor", silent = true })

vim.keymap.set('n', 'gh', function()
  -- TODO extract the search for the declaration node for reusability
  local ts_utils = require 'nvim-treesitter.ts_utils'
  local node = ts_utils.get_node_at_cursor()
  while node do
    -- TODO *_declaration for it to also work for type definitons, etc.
    if node:type() == 'function_declaration' or node:type() == 'method_declaration' then
      local children = ts_utils.get_named_children(node)
      for _, child in ipairs(children) do
        -- TODO *_identifier for it to also work for type definitons, etc.
        if child:type() == 'identifier' or child:type() == 'field_identifier' then
          ts_utils.goto_node(child)
          return
        end
      end
    end
    node = node:parent()
  end
end, { desc = "[G]oto function [h]ead", silent = true })

vim.keymap.set('n', 'gp', function()
  -- TODO extract the search for the declaration node for reusability
  local ts_utils = require 'nvim-treesitter.ts_utils'
  local node = ts_utils.get_node_at_cursor()
  while node do
    if node:type() == 'function_declaration' or node:type() == 'method_declaration' then
      local children = ts_utils.get_named_children(node)
      for index, child in ipairs(children) do
        if child:type() == 'identifier' or child:type() == 'field_identifier' then
          ts_utils.goto_node(children[index + 1])
          return
        end
      end
    end
    node = node:parent()
  end
end, { desc = "[G]oto function [p]arameter list", silent = true })

vim.keymap.set('n', '<C-Up>', function()
  -- TODO extract the search for the declaration node for reusability
  local ts_utils = require 'nvim-treesitter.ts_utils'
  local node = ts_utils.get_node_at_cursor()
  while node do
    -- TODO *_declaration for it to also work for type definitons, etc.
    if node:type() == 'function_declaration' or node:type() == 'method_declaration' or node:type() == 'type_declaration' or node:type() == 'import_declaration' then
      ts_utils.goto_node(node:prev_sibling())
    end
    node = node:parent()
  end
end, { desc = "Goto previous function", silent = true })

vim.keymap.set('n', '<C-Down>', function()
  -- TODO extract the search for the declaration node for reusability
  local ts_utils = require 'nvim-treesitter.ts_utils'
  local node = ts_utils.get_node_at_cursor()
  while node do
    -- TODO *_declaration for it to also work for type definitons, etc.
    if node:type() == 'function_declaration' or node:type() == 'method_declaration' or node:type() == 'type_declaration' or node:type() == 'import_declaration' then
      ts_utils.goto_node(node:next_sibling())
    end
    node = node:parent()
  end
end, { desc = "Goto next function", silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, { desc = "[G]oto [D]efinition" })
vim.keymap.set('n', 'gr', function()
  require('telescope.builtin').lsp_references({
    entry_maker = function(entry)
      local formatted_entry = require('telescope.make_entry').gen_from_quickfix({})(entry)
      Original_Display = formatted_entry.display
      if string.find(entry.filename, "test") then
        formatted_entry.display = function(f)
          local original_display_string, path_style = Original_Display(f)
          return " " .. original_display_string, path_style
        end
      elseif string.find(entry.filename, "mock") then
        formatted_entry.display = function(f)
          local original_display_string, path_style = Original_Display(f)
          return " " .. original_display_string, path_style
        end
      else
        formatted_entry.display = function(f)
          local original_display_string, path_style = Original_Display(f)
          return " " .. original_display_string, path_style
        end
      end
      return formatted_entry
    end,
  })
end, { desc = "[G]oto [R]eferences" })
vim.keymap.set('n', 'gI', function()
  require('telescope.builtin').lsp_implementations({
    entry_maker = function(entry)
      local formatted_entry = require('telescope.make_entry').gen_from_quickfix({})(entry)
      Original_Display = formatted_entry.display
      if string.find(entry.filename, "mock") then
        formatted_entry.display = function(f)
          local original_display_string, path_style = Original_Display(f)
          return " " .. original_display_string, path_style
        end
      else
        formatted_entry.display = function(f)
          local original_display_string, path_style = Original_Display(f)
          return " " .. original_display_string, path_style
        end
      end
      return formatted_entry
    end,
  })
end, { desc = "[G]oto [I]mplementation" })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = "[G]oto [T]ype Definition" })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })

vim.keymap.set('n', '<leader>fr', vim.lsp.buf.rename, { desc = "[R]ename" })
vim.keymap.set('n', '<leader>do', vim.lsp.buf.hover, { desc = "Hover Documentation" })
vim.keymap.set('n', '<leader>dd', vim.lsp.buf.signature_help, { desc = "Signature Documentation" })

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    -- if desc then
    -- desc = 'LSP: ' .. desc
    -- end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')


  -- Lesser used LSP functionality
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  gopls = {
    -- Mason manages its own gopls version
    -- run :MasonInstall gopls to install the latest version after a Go update
    -- https://github.com/golang/go/issues/66743#issuecomment-2045815517
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
  pyright = {},
  -- rust_analyzer = {},
  -- ts_ls = {},
  vtsls = {}, -- alternative to ts_ls
  eslint = {},
  cssls = {},
  cssmodules_ls = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  jsonls = {},
}

vim.keymap.set('n', '<leader>.', ':EslintFixAll<CR>', { desc = 'Eslint: Fix All' })

local function organize_imports()
  local ft = vim.bo.filetype:gsub("react$", "")

  if not vim.tbl_contains({ "javascript", "typescript" }, ft) then
    -- Organize imports is only available for JavaScript/TypeScript files
    return
  end

  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if #clients == 0 then
    -- No LSP client attached to current buffer
    return
  end

  local ok = vim.lsp.buf_request_sync(0, "workspace/executeCommand", {
    command = (ft .. ".organizeImports"),
    arguments = { vim.api.nvim_buf_get_name(0) },
  }, 3000)

  if not ok then
    print("Command timeout or failed to complete.")
  else
    print("Imports organized successfully")
  end
end

vim.api.nvim_create_user_command('OrganizeImports', organize_imports, {
  desc = "Organize imports for JavaScript/TypeScript files",
})
vim.keymap.set('n', '<leader>fi', organize_imports, { desc = "Organize [i]mports" })

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

-- FIXME this is broken since the new major mason version. removing it fixes the
-- error but may prevent autoloading lsps
-- https://github.com/mason-org/mason-lspconfig.nvim/issues/545
-- mason_lspconfig.setup_handlers {
--   function(server_name)
--     require('lspconfig')[server_name].setup {
--       capabilities = capabilities,
--       on_attach = on_attach,
--       settings = servers[server_name],
--     }
--   end,
-- }

vim.api.nvim_create_augroup('AutoFormatting', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*', -- could be e.g. '*.go'
  group = 'AutoFormatting',
  callback = function()
    vim.lsp.buf.format()
  end,
})
-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

require('custom.functions.go-endpoints')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
