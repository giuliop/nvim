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

-- Format and organize imports for Go files on save
autocmd("BufWritePre", {
  group = augroup("GoFormat", { clear = true }),
  pattern = "*.go",
  callback = function()
    -- Only proceed if an LSP client is attached; avoids first-save warnings
    local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients
    local clients = {}
    if get_clients then
      if vim.lsp.get_clients then
        clients = get_clients({ bufnr = 0 }) or {}
      else
        clients = get_clients() or {}
      end
    end
    if #clients == 0 then
      return
    end

    -- Use the first client's offset_encoding (utf-16 for most servers like gopls)
    local position_encoding = clients[1].offset_encoding or "utf-16"

    -- Pass required position_encoding to avoid deprecation/warning
    local params = vim.lsp.util.make_range_params(nil, position_encoding)
    params.context = { only = { "source.organizeImports" } }

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or position_encoding
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end

    vim.lsp.buf.format({ async = false })
  end,
  desc = "Organize imports and format Go files on save",
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

-- Save and restore colorscheme and background
local theme_file = vim.fn.stdpath("data") .. "/theme.txt"

-- Load saved colorscheme and background on startup (skip in VSCode)
autocmd("VimEnter", {
  group = augroup("RestoreTheme", { clear = true }),
  callback = function()
    if vim.g.vscode then
      return
    end
    
    local file = io.open(theme_file, "r")
    if file then
      local colorscheme = file:read("*line")
      local background = file:read("*line")
      file:close()
      
      if background and (background == "light" or background == "dark") then
        vim.opt.background = background
      end
      
      if colorscheme and colorscheme ~= "" then
        vim.cmd("colorscheme " .. colorscheme)
      else
        vim.cmd("colorscheme onehalfdark")  -- fallback
      end
    else
      vim.cmd("colorscheme onehalfdark")  -- fallback
    end
  end,
  desc = "Restore last used colorscheme and background",
})

-- Save colorscheme and background when either changes
local function save_theme()
  local file = io.open(theme_file, "w")
  if file then
    file:write((vim.g.colors_name or "onehalfdark") .. "\n")
    file:write(vim.o.background .. "\n")
    file:close()
  end
end

autocmd("ColorScheme", {
  group = augroup("SaveTheme", { clear = true }),
  callback = save_theme,
  desc = "Save current colorscheme and background",
})

autocmd("OptionSet", {
  group = augroup("SaveTheme", { clear = false }),
  pattern = "background",
  callback = save_theme,
  desc = "Save background setting when changed",
})

-- Theme toggles (persist via existing autocmds)
do
  local themes = { "solarized", "everforest", "nord", "onehalfdark" }

  local function cycle_theme()
    local current = vim.g.colors_name or ""
    local idx = 0
    for i, name in ipairs(themes) do
      if name == current then idx = i break end
    end
    for step = 1, #themes do
      local j = ((idx + step - 1) % #themes) + 1
      local ok = pcall(vim.cmd, "colorscheme " .. themes[j])
      if ok then return end
    end
  end

  local function toggle_background()
    vim.opt.background = (vim.o.background == "light") and "dark" or "light"
  end

  vim.api.nvim_create_user_command("ThemeCycle", cycle_theme, { desc = "Cycle through preferred themes" })
  vim.api.nvim_create_user_command("BackgroundToggle", toggle_background, { desc = "Toggle background light/dark" })

  vim.keymap.set("n", "<leader>tt", cycle_theme, { desc = "Cycle themes" })
  vim.keymap.set("n", "<leader>tb", toggle_background, { desc = "Toggle background" })
end
