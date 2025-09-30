local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  -- Status bar
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = false,
          component_separators = '',
          section_separators = '',
        },
      }
    end
  },

  -- Dev stuff (telescope, lsp, highlighting, autocompletion)
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      disable_filetype = { "TelescopePrompt" },
    }
  },
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          preview = false -- Preview disabled
        }

      }

      pcall(require('telescope').load_extension, 'fzf')
      local builtin = require("telescope.builtin")
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<Leader>pf', builtin.find_files, opts)
      vim.keymap.set('n', '<Leader>E', builtin.diagnostics, opts)
      vim.keymap.set('n', '<C-p>', builtin.git_files, opts)
      vim.keymap.set('n', '<leader>ps', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") });
      end)
    end
  },
  --
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.enable('gopls')
      vim.lsp.config('html', {
        filetypes = { 'html' }
      })
      vim.lsp.enable('html')
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = { diagnostics = { globals = { 'vim' }, }, },
        },
      })
      vim.lsp.enable('lua_ls')

      vim.lsp.enable('ts_ls')
      vim.lsp.config('vue_ls', {
        filetypes = { 'vue' },
        init_options = {
          typescript = {
            tsdk = '/home/ale/.local/lib/node_modules/typescript/lib'
          }
        }
      })
      vim.lsp.enable("vue_ls")

      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('<leader>f', function() vim.lsp.buf.format { async = true } end, '[F]ormat document')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
    end,
  },
  --
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      -- 'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require 'cmp'
      vim.opt.completeopt = { "menu", "menuone", "noselect" }

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        }
        )
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = 'buffer' },
        })
      })
    end
  },
  --
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { "bash", "c", "css", "dockerfile", "go", "graphql", "javascript", "lua", "python", "typescript", "vue", "markdown" },
      sync_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      }
    },
    config = function(_, opts)
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end
  },
  --
  --
  {
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false
  },
  --
  {
    'ThePrimeagen/harpoon',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>a", mark.add_file)
      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

      for key = 1, 5 do
        local keymap = string.format('<leader>%d', key)
        vim.keymap.set('n', keymap, function() ui.nav_file(key) end)
      end
    end
  },
}

local opts = {
  rocks = {
    enabled = false
  }
}
require("lazy").setup(plugins, opts)
