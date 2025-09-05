## Architecture Overview

This is a modern Neovim configuration written in Lua, organized into modular components:

- **init.lua**: Entry point that loads all configuration modules
- **lua/config/**: Core configuration modules
  - `options.lua`: Editor settings (indentation, UI, search behavior)
  - `keymaps.lua`: Custom key mappings and leader key shortcuts
  - `autocmds.lua`: Autocommands for file handling and Python execution
  - `lazy.lua`: Plugin management and configuration using lazy.nvim

## Plugin Architecture

The configuration uses lazy.nvim for plugin management with these key plugins:

### Core Functionality
- **nvim-surround**: Text object manipulation for quotes/brackets/tags
- **unimpaired.nvim**: Bracket mappings for navigation and toggling
- **nvim-tree.lua**: File explorer sidebar (`<leader>2` to toggle)
- **telescope.nvim**: Fuzzy finder with FZF integration for files, grep, buffers

### Development Tools
- **Mason ecosystem**: LSP server management
  - `mason.nvim`: LSP installer interface
  - `mason-lspconfig.nvim`: Bridge between Mason and lspconfig
  - `nvim-lspconfig`: LSP client configurations
- **TypeScript Tools**: Enhanced TypeScript development with `typescript-tools.nvim`
- **GitHub Copilot**: AI-powered code completion
- **Markdown Preview**: Live markdown preview with `markdown-preview.nvim`
- **Language servers**: lua_ls, ts_ls, pyright, gopls (auto-installed via Mason)

### UI/Theme
- **solarized.nvim**: Light theme with summer variant
- **everforest**: Alternative theme option
- **nord.nvim**: Alternative theme option
- **onehalf**: Alternative theme with onehalfdark fallback
- **lualine.nvim**: Status line with solarized_light theme
- **nvim-web-devicons**: File type icons

## Key Mappings

### Leader Key: `<Space>`

**File Operations:**
- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Live grep search
- `<leader>fb` - Browse buffers
- `<leader>fr` - Recent files
- `<leader>fh` - Help tags

**Window Management:**
- `<leader>v` - Vertical split
- `<leader>s` - Horizontal split
- `<leader>n` - New file in vertical split
- `<leader>q` - Quit
- `<leader>w` - Close buffer
- `<leader>3` - Toggle line numbers

**Terminal:**
- `<leader>r` - Open bash terminal in vertical split
- Python files: `<leader>r` - Run current Python file interactively

**Theme Management:**
- `<leader>tt` - Cycle through themes (solarized, everforest, nord, onehalfdark)
- `<leader>tb` - Toggle background (light/dark)

**Markdown:**
- `<leader>p` - Open markdown preview

### Navigation & Editing
- `H` - Move to first non-blank character (replaces `^`)
- `L` - Move to end of line (replaces `$`)
- `;` - Enter command mode (replaces `:`)
- `:` - Repeat f/F/t/T (replaces `;`)
- `Q` - Replay macro q
- `Ctrl+h/j/k/l` - Window navigation
- `Ctrl+s` - Save and clear search highlight
- Arrow keys - Window resizing (left/right: width, up/down: height)

### Terminal Mode
- `Esc` - Exit terminal mode
- `Ctrl+w q` - Close terminal buffer

### Insert Mode
- `Ctrl+W` - Delete previous word
- `Ctrl+U` - Delete to start of line

### Visual Mode
- `<` - Indent left and reselect
- `>` - Indent right and reselect
- `.` - Apply . command to selection

### LSP Bindings (when LSP server attached)
- `gd` - Go to definition
- `K` - Hover documentation
- `gi` - Go to implementation
- `gr` - Find references
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions

## Configuration Management

### Plugin Management
```bash
# Install/update plugins
:Lazy

# Plugin status and management UI
:Lazy
```

### LSP Management
```bash
# Mason LSP installer interface
:Mason

# LSP server info
:LspInfo
```

### File Tree
```bash
# Toggle file explorer
<leader>2

# Within nvim-tree:
v    # Open file in vertical split
s    # Open file in horizontal split
```

### Theme Commands
```bash
# Cycle through themes
:ThemeCycle

# Toggle background light/dark
:BackgroundToggle
```

### Markdown Preview
```bash
# Start/stop markdown preview
:MarkdownPreview
:MarkdownPreviewStop
:MarkdownPreviewToggle
```

## Development Workflow

### Typical Editing Session
1. Open Neovim: `nvim`
2. Use `<leader>ff` to find files or `<leader>2` for file tree
3. Navigate with custom H/L mappings and Ctrl+hjkl for windows
4. Use LSP features (gd, K, gr) for code navigation
5. Python development: `<leader>r` runs files interactively
6. Save with `<Ctrl+s>` (also clears search highlight)

### Plugin Development
- Plugins are lazy-loaded based on events or file types
- VSCode integration: Many plugins disabled when `vim.g.vscode` is set
- Configuration changes require `:source` or restart

## Important Behaviors

### Auto-commands
- Trailing whitespace automatically removed on save
- Cursor position restored when reopening files
- Python files get special terminal runner keybind
- Go files automatically formatted with LSP on save (with import organization)
- Colorscheme and background automatically saved and restored across sessions
- Auto-display diagnostics when cursor hovers over error lines

### Editor Preferences
- 4-space indentation with tabs converted to spaces
- Relative line numbers with absolute for current line
- Persistent colorscheme/background settings (defaults to onehalfdark)
- Mouse enabled for all modes
- Case-insensitive search with smart case sensitivity
- System clipboard integration
- Floating diagnostic windows with rounded borders
- TypeScript inlay hints and enhanced completions

## Commit Guidelines

When creating commits, do NOT include the following footer:
```
🤖 Generated with [Claude Code](https://claude.ai/code)

Co-Authored-By: Claude <noreply@anthropic.com>
```
