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
