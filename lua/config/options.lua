local opt = vim.opt

-- General settings
opt.mouse = "a"                   -- Enable mouse mode
opt.undofile = true               -- Enable persistent undo
opt.clipboard = "unnamedplus"     -- Use system clipboard for yank/paste
opt.confirm = true                -- Confirm to save changes on exit

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
opt.signcolumn = "yes"            -- Always show sign column to avoid jitter
opt.showmode = false              -- Hide mode since lualine shows it

-- Search settings
opt.ignorecase = true             -- Case insensitive search
opt.smartcase = true              -- Case sensitive when uppercase present
opt.inccommand = "split"          -- Live preview of substitute commands

-- Window behavior
opt.splitright = true             -- New vertical splits open to the right
opt.splitbelow = true             -- New horizontal splits open below

-- Scroll behavior
opt.scrolloff = 3                 -- Minimum lines above/below cursor

-- Other useful settings
opt.startofline = false          -- Don't jump to first character with page commands
opt.updatetime = 300             -- Faster completion and diagnostics (default 4000ms)
opt.timeoutlen = 400             -- Faster mapped sequence timeout

vim.diagnostic.config({
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

local severity_labels = {
  [vim.diagnostic.severity.ERROR] = "Error",
  [vim.diagnostic.severity.WARN] = "Warning",
  [vim.diagnostic.severity.INFO] = "Info",
  [vim.diagnostic.severity.HINT] = "Hint",
}

local severity_highlights = {
  [vim.diagnostic.severity.ERROR] = "DiagnosticError",
  [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
  [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
  [vim.diagnostic.severity.HINT] = "DiagnosticHint",
}

-- Auto-show diagnostics when cursor is on error line
vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
  callback = function()
    local cursor_position = vim.api.nvim_win_get_cursor(0)
    local diagnostics = vim.diagnostic.get(0, { lnum = cursor_position[1] - 1 })

    if #diagnostics == 0 then
      vim.api.nvim_echo({{""}}, false, {})
      return
    end

    local chunks = {}
    for index, diagnostic in ipairs(diagnostics) do
      local label = severity_labels[diagnostic.severity] or "Info"
      local message = diagnostic.message:gsub("\n", " ")
      local highlight = severity_highlights[diagnostic.severity] or "DiagnosticInfo"

      table.insert(chunks, { string.format("%s: %s", label, message), highlight })

      if index < #diagnostics then
        table.insert(chunks, { "  |  ", "Normal" })
      end
    end

    vim.api.nvim_echo(chunks, false, {})
  end
})

-- Graphics and theming
-- Background setting is now managed by autocmds for persistence
