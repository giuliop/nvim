local opt = vim.opt

-- General settings
opt.mouse = ""                    -- Disable mouse mode
opt.undofile = true               -- Enable persistent undo

-- Indentation and formatting
opt.shiftwidth = 4                -- Use indents of 4 spaces
opt.expandtab = true              -- Convert tabs to spaces
opt.tabstop = 4                   -- Tab width of 4 columns
opt.softtabstop = 4               -- Backspace deletes indent properly

-- UI settings
opt.cursorline = true             -- Highlight current line
opt.relativenumber = true         -- Show relative line numbers
opt.number = true                 -- Also show absolute line number for current line
opt.termguicolors = true          -- Enable true color support

-- Search settings
opt.ignorecase = true             -- Case insensitive search
opt.smartcase = true              -- Case sensitive when uppercase present

-- Window behavior
opt.splitright = true             -- New vertical splits open to the right
opt.splitbelow = true             -- New horizontal splits open below

-- Scroll behavior
opt.scrolloff = 3                 -- Minimum lines above/below cursor

-- Other useful settings
opt.startofline = false          -- Don't jump to first character with page commands

-- Graphics and theming
vim.opt.background = "light"
