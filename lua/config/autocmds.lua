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

-- Format Go files on save with gofmt
autocmd("BufWritePre", {
  group = augroup("GoFormat", { clear = true }),
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
  desc = "Format Go files on save",
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

-- Save and restore colorscheme
local colorscheme_file = vim.fn.stdpath("data") .. "/colorscheme.txt"

-- Load saved colorscheme on startup
autocmd("VimEnter", {
  group = augroup("RestoreColorscheme", { clear = true }),
  callback = function()
    local file = io.open(colorscheme_file, "r")
    if file then
      local colorscheme = file:read("*line")
      file:close()
      if colorscheme and colorscheme ~= "" then
        vim.cmd("colorscheme " .. colorscheme)
      else
        vim.cmd("colorscheme onehalfdark")  -- fallback
      end
    else
      vim.cmd("colorscheme onehalfdark")  -- fallback
    end
  end,
  desc = "Restore last used colorscheme",
})

-- Save colorscheme when it changes
autocmd("ColorScheme", {
  group = augroup("SaveColorscheme", { clear = true }),
  callback = function()
    local file = io.open(colorscheme_file, "w")
    if file then
      file:write(vim.g.colors_name)
      file:close()
    end
  end,
  desc = "Save current colorscheme",
})
