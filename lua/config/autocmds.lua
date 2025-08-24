-- Autocommands configuration
-- Simplified and modernized from init.vim

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("TrimWhitespace", { clear = true }),
  pattern = "*",
  command = "%s/\\s\\+$//e",
  desc = "Remove trailing whitespace on save",
})

-- Python-specific terminal command
autocmd("FileType", {
  group = augroup("PythonRunner", { clear = true }),
  pattern = "python",
  callback = function()
    vim.keymap.set("n", "<leader>r", ":vnew term://python3 -i %<CR>a", 
      { buffer = true, desc = "Run Python file interactively" })
  end,
})

-- Auto-change to file directory (only outside VSCode)
if not vim.env.VSCODE_NEO_VIM then
  autocmd("BufEnter", {
    group = augroup("AutoChangeDir", { clear = true }),
    callback = function()
      local buf_name = vim.api.nvim_buf_get_name(0)
      if buf_name ~= "" and vim.fn.isdirectory(vim.fn.fnamemodify(buf_name, ":p:h")) == 1 then
        vim.cmd("tcd " .. vim.fn.fnamemodify(buf_name, ":p:h"))
      end
    end,
    desc = "Change to file directory on buffer enter",
  })
end

-- HTML file settings
autocmd("FileType", {
  group = augroup("HtmlSettings", { clear = true }),
  pattern = "html",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.wrap = false
    vim.opt_local.list = false
  end,
  desc = "HTML-specific settings",
})

-- Remember last cursor position
autocmd("BufReadPost", {
  group = augroup("RestoreCursor", { clear = true }),
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 1 and line <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
  desc = "Restore cursor position on file open",
})

-- Teal file comment settings
autocmd({ "BufNewFile", "BufRead" }, {
  group = augroup("TealSettings", { clear = true }),
  pattern = "*.teal",
  callback = function()
    vim.opt_local.comments:append("://")
  end,
  desc = "Set comment options for Teal files",
})