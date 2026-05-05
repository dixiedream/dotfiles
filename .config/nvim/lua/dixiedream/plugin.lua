if not vim.pack then
  vim.notify('vim.pack is missing; use Neovim 0.12+', vim.log.levels.ERROR)
  return
end

vim.api.nvim_create_user_command('PackUpdate', function()
  vim.pack.update()
end, { desc = 'Run vim.pack.update()' })

local gh = function(repo)
  return 'https://github.com/' .. repo
end

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then
      return
    end
    if name == 'telescope-fzf-native.nvim' and vim.fn.executable('make') == 1 then
      vim.system({ 'make' }, { cwd = ev.data.path }):wait()
    end
  end,
})

vim.pack.add({
  gh('nvim-lua/plenary.nvim'),
  { src = gh('folke/tokyonight.nvim') },
  { src = gh('nvim-lualine/lualine.nvim') },
  { src = gh('numToStr/Comment.nvim') },
  {
    src = gh('nvim-treesitter/nvim-treesitter'),
    version = 'main',
    build = ':TSUpdate'
  },
  { src = gh('windwp/nvim-autopairs') },
  { src = gh('nvim-telescope/telescope-fzf-native.nvim') },
  {
    src = gh('nvim-telescope/telescope.nvim'),
    version = 'master',
  },
  { src = gh('hrsh7th/cmp-buffer') },
  { src = gh('hrsh7th/cmp-nvim-lsp') },
  { src = gh('hrsh7th/nvim-cmp') },
  { src = gh('neovim/nvim-lspconfig') },
  { src = gh('ThePrimeagen/harpoon') },
}, { load = true })

vim.cmd.colorscheme('tokyonight')

require('lualine').setup({
  options = {
    icons_enabled = false,
    component_separators = '',
    section_separators = '',
  },
})

require('Comment').setup({})

do
  local parsers = {
    'bash',
    'c',
    'css',
    'dockerfile',
    'go',
    'graphql',
    'javascript',
    'lua',
    'python',
    'typescript',
    'vue',
    'markdown',
    'zig',
  }
  require('nvim-treesitter').install(parsers)
  local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
  vim.api.nvim_create_autocmd('FileType', {
    pattern = { '<filetype>' },
    group = group,
    callback = function() vim.treesitter.start() end,
  })
end

local autopairs = require('nvim-autopairs')
autopairs.setup({
  check_ts = true,
  ts_config = {
    lua = { 'string', 'source' },
    javascript = { 'string', 'template_string' },
    typescript = { 'string', 'template_string' },
    typescriptreact = { 'string', 'template_string' },
    java = false,
  },
  disable_filetype = { 'TelescopePrompt' },
})

require('telescope').setup({
  defaults = {
    preview = false,
  },
})
pcall(require('telescope').load_extension, 'fzf')

do
  local builtin = require('telescope.builtin')
  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', '<Leader>pf', builtin.find_files, opts)
  vim.keymap.set('n', '<Leader>E', builtin.diagnostics, opts)
  vim.keymap.set('n', '<C-p>', builtin.git_files, opts)
  vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input('Grep > ') })
  end)
end

do
  local cmp = require('cmp')
  cmp.setup({
    snippet = {
      expand = function(args)
        vim.snippet.expand(args.body)
      end,
    },
    window = {},
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    }),
  })
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' },
    }, {
      { name = 'buffer' },
    }),
  })
end

do
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
  vim.lsp.config('*', { capabilities = capabilities })

  vim.lsp.enable('gopls')
  vim.lsp.enable('zls')
  vim.lsp.config('html', {
    filetypes = { 'html' },
  })
  vim.lsp.enable('html')
  vim.lsp.config('lua_ls', {
    settings = {
      Lua = { diagnostics = { globals = { 'vim' } } },
    },
  })
  vim.lsp.enable('lua_ls')
  vim.lsp.enable('ts_ls')
  vim.lsp.enable('intelephense')

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
      map('<leader>ca', function()
        vim.lsp.buf.code_action({
          filter = function(action)
            return action.disabled == nil
          end,
        })
      end, '[C]ode [A]ction')
      map('K', vim.lsp.buf.hover, 'Hover Documentation')
      map('<leader>f', function()
        vim.lsp.buf.format({ async = true })
      end, '[F]ormat document')

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
end

do
  local mark = require('harpoon.mark')
  local ui = require('harpoon.ui')
  vim.keymap.set('n', '<leader>a', mark.add_file)
  vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)
  for key = 1, 5 do
    local keymap = string.format('<leader>%d', key)
    vim.keymap.set('n', keymap, function()
      ui.nav_file(key)
    end)
  end
end
