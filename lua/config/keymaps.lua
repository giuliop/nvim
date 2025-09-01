local keymap = vim.keymap.set

-- Set leader key
vim.g.mapleader = " "

-- Easy movement to first non-space and end of line
keymap("n", "H", "^", { desc = "Go to first non-blank character" })
keymap("n", "L", "$", { desc = "Go to end of line" })

-- Swap semicolon and colon for easier commands
keymap("n", ";", ":", { desc = "Enter command mode" })
keymap("n", ":", ";", { desc = "Repeat f/F/t/T" })

-- Window navigation with Ctrl + movement keys
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Terminal mode mappings
keymap("t", "<ESC>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap("t", "<C-w>q", "<C-\\><C-n>:bd!<CR>", { desc = "Close terminal buffer" })

-- Window resizing with arrow keys
keymap("n", "<left>", "<C-w>2>", { desc = "Increase window width" })
keymap("n", "<down>", "<C-w>2+", { desc = "Increase window height" })
keymap("n", "<up>", "<C-w>2-", { desc = "Decrease window height" })
keymap("n", "<right>", "<C-w>2<", { desc = "Decrease window width" })

-- Insert mode editing shortcuts
keymap("i", "<C-W>", "<C-\\><C-O>db", { desc = "Delete previous word in insert mode" })
keymap("i", "<C-U>", "<C-\\><C-O>d0", { desc = "Delete to start of line in insert mode" })

-- Visual mode improvements
keymap("v", "<", "<gv", { desc = "Indent left and reselect" })
keymap("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Macro replay with Q
keymap("n", "Q", "@q", { desc = "Replay macro q" })

-- Apply . command to visual selection
keymap("v", ".", ":normal .<CR>", { desc = "Apply . to visual selection" })

-- Save and clear search highlight
keymap("n", "<C-s>", ":noh<CR>:w<CR>", { desc = "Save file and clear search highlight" })
keymap("i", "<C-s>", "<ESC>:noh<CR>:w<CR>", { desc = "Save file and clear search highlight" })

-- Leader key mappings
keymap("n", "<leader><Space>", ":noh<CR>", { desc = "Clear search highlight" })
keymap("n", "<leader>n", ":vne<CR>", { desc = "Open new file in vertical split" })
keymap("n", "<leader>e", ":e! ~/.config/nvim/init.lua<CR>", { desc = "Edit init.lua" })
keymap("n", "<leader>v", "<C-w>v<C-w>l", { desc = "Open vertical split" })
keymap("n", "<leader>s", "<C-w>s<C-w>l", { desc = "Open horizontal split" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>w", ":bw<CR>", { desc = "Close buffer" })
keymap("n", "<leader>r", ":vnew term://bash<CR>a", { desc = "Open terminal in vertical split" })
keymap("n", "<leader>3", ":set nu! rnu!<CR>", { desc = "Toggle line numbers" })
