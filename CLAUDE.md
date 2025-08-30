# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

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
- **GitHub Copilot**: AI-powered code completion
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
- `<leader>e` - Edit init.lua

**Window Management:**
- `<leader>v` - Vertical split
- `<leader>s` - Horizontal split  
- `<leader>n` - New file in vertical split
- `<leader>q` - Quit
- `<leader>w` - Close buffer

**Terminal:**
- `<leader>r` - Open bash terminal in vertical split
- Python files: `<leader>r` - Run current Python file interactively

### Navigation & Editing
- `H` - Move to first non-blank character (replaces `^`)
- `L` - Move to end of line (replaces `$`) 
- `;` - Enter command mode (replaces `:`)
- `:` - Repeat f/F/t/T (replaces `;`)
- `Q` - Replay macro q
- `Ctrl+h/j/k/l` - Window navigation
- `Ctrl+s` - Save and clear search highlight

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
- Go files automatically formatted with LSP on save
- Colorscheme automatically saved and restored across sessions

### Editor Preferences
- 4-space indentation with tabs converted to spaces
- Relative line numbers with absolute for current line
- Light background theme (Solarized summer variant)
- Mouse enabled for all modes
- Case-insensitive search with smart case sensitivity
- Automatic colorscheme persistence across sessions (defaults to onehalfdark)
- Go files automatically formatted with LSP on save