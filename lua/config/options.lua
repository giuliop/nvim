-- Neovim options configuration
-- Simplified and modernized from init.vim

local opt = vim.opt

-- General settings
opt.mouse = ""                    -- Disable mouse mode
opt.undofile = true               -- Enable persistent undo

-- Indentation and formatting
opt.shiftwidth = 4                -- Use indents of 4 spaces
opt.expandtab = true              -- Convert tabs to spaces
opt.tabstop = 4                   -- Tab width of 4 columns
opt.softtabstop = 4               -- Backspace deletes indent properly
opt.textwidth = 0                 -- No hard-wrap of long lines

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

-- Command line completion
opt.wildmode = { "list:longest", "full" }  -- Better command completion

-- Other useful settings
opt.joinspaces = false            -- Don't insert two spaces after punctuation
opt.whichwrap:append("<,>,[,],h,l")  -- Allow cursor keys to wrap
opt.foldenable = true             -- Enable code folding
opt.startofline = false          -- Don't jump to first character with page commands

-- Graphics and theming
vim.opt.background = "dark"
vim.cmd.colorscheme("nord")
