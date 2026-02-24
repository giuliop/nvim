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
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "tummetott/unimpaired.nvim",
    config = function()
      require("unimpaired").setup()
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    cond = not vim.g.vscode,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
        renderer = { group_empty = true },
        filters = {
          dotfiles = false,
          git_ignored = false,
        },
        git = {
          ignore = false,
        },
        on_attach = function(bufnr)
          local api = require('nvim-tree.api')
          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
          vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
          vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
          vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
        end,
      })
      vim.keymap.set("n", "<leader>2", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    cond = not vim.g.vscode,
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = {
            "%.git/",
            "node_modules",
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            follow = true,
            no_ignore = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      })

      require('telescope').load_extension('fzf')

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Telescope recent files" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    cond = not vim.g.vscode,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "solarized_light",
        },
        sections = {
          lualine_c = {
            { "filename", path = 4 },
          },
        },
      })
    end,
  },

  {
    "maxmx03/solarized.nvim",
    cond = not vim.g.vscode,
    config = function()
      require('solarized').setup({
        variant = 'summer', -- light theme
      })
    end,
  },

  {
    "sainnhe/everforest",
    cond = not vim.g.vscode,
  },

  {
    "shaunsingh/nord.nvim",
    cond = not vim.g.vscode,
  },

  {
    "sonph/onehalf",
    cond = not vim.g.vscode,
    config = function()
      vim.opt.rtp:append(vim.fn.expand("~/.local/share/nvim/lazy/onehalf/vim"))
    end,
  },

  {
    "github/copilot.vim",
    cond = not vim.g.vscode,
  },

  {
    "iamcco/markdown-preview.nvim",
    -- Load only on macOS to avoid issues on headless/Ubuntu server
    cond = function()
      return (not vim.g.vscode) and (vim.loop.os_uname().sysname == "Darwin")
    end,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_browser = 'Google Chrome'
      vim.keymap.set("n", "<leader>p", ":MarkdownPreview<CR>", { desc = "Open markdown preview" })
    end,
  },

  -- LSP Configuration
  {
    "williamboman/mason.nvim",
    cond = not vim.g.vscode,
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    cond = not vim.g.vscode,
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "pyright", "gopls" },
        automatic_enable = {
          exclude = { "ts_ls" },
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    cond = not vim.g.vscode,
    dependencies = { "mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      -- Custom hover function that displays at the bottom like diagnostics
      local hover_suppress_ms = 3000

      local function hover_at_bottom()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        if #clients == 0 then
          return
        end

        local params = vim.lsp.util.make_position_params(0, clients[1].offset_encoding)
        vim.lsp.buf_request(0, 'textDocument/hover', params, function(err, result, ctx, config)
          if err or not result or not result.contents then
            vim.api.nvim_echo({{ "", "Normal" }}, false, {})
            return
          end

          local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
          local contents = table.concat(markdown_lines, " ")

          -- Remove excessive whitespace and markdown formatting for command line display
          contents = contents:gsub("\n+", " "):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")

          if contents ~= "" then
              vim.api.nvim_echo({{ contents, "Normal" }}, false, {})
              local now = vim.loop and vim.loop.hrtime and vim.loop.hrtime()
              if now then
                vim.g.__hover_message_suppress_until = now + (hover_suppress_ms * 1e6)
              end
          end
        end)
      end

      -- LSP keybindings
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", hover_at_bottom, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    cond = not vim.g.vscode,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },

  -- TypeScript ergonomics (uses typescript-language-server under the hood)
  {
    "pmizio/typescript-tools.nvim",
    cond = not vim.g.vscode,
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup({
        settings = {
          separate_diagnostic_server = true,
          publish_diagnostic_on = "insert_leave",
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeCompletionsForModuleExports = true,
            quotePreference = "auto",
          },
        },
      })
    end,
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
