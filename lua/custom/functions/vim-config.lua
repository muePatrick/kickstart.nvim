-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Set line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Set columns
vim.wo.cursorline = true
vim.wo.cursorcolumn = true
vim.opt.colorcolumn = "80,100"
vim.wo.signcolumn = 'yes' -- Keep signcolumn on by default

-- Set scrolloff
vim.o.scrolloff = 5

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true



-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.spell = true
vim.o.spelllang = 'en_us,de_20'

vim.diagnostic.config({ virtual_lines = false }) -- shows diagnostics grayed out at the end of the line
vim.diagnostic.config({ virtual_text = true })   -- shows diagnostics in the line below
