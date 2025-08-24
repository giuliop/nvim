-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-unimpaired" },

  {
    "nvim-tree/nvim-tree.lua",
    cond = not vim.g.vscode,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
        renderer = { group_empty = true },
        filters = { dotfiles = false },
      })
      vim.keymap.set("n", "<leader>2", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    cond = not vim.g.vscode,
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
      
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>p", builtin.oldfiles, { desc = "Recent files" })
      vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Switch buffers" })
      vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    cond = not vim.g.vscode,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "nord",
        },
      })
    end,
  },

  {
    "arcticicestudio/nord-vim",
    cond = not vim.g.vscode,
    config = function()
      vim.cmd.colorscheme("nord")
    end,
  },

  {
    "github/copilot.vim",
    cond = not vim.g.vscode,
  },
}, {
  -- Lazy.nvim configuration
  ui = {
    border = "rounded",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
