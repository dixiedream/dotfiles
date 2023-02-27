local opts = { noremap = true, silent = true }
-- Disables diagnostics noise on the right
vim.diagnostic.config({ virtual_text = false })
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local bufopts = { remap = false, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local nvim_lsp = require('lspconfig')

-- GoLang
nvim_lsp.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

-- HTML
nvim_lsp.html.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { 'html' }
}

-- Lua
nvim_lsp.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = { diagnostics = { globals = { 'vim' }, }, },
  },
  on_attach = on_attach
}

-- PHP
nvim_lsp.intelephense.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { 'php' }
}

-- Rust
nvim_lsp.rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- Typescript
nvim_lsp.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

-- VueJs
nvim_lsp.volar.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { 'vue' },
  init_options = {
    typescript = {
      tsdk = '/home/ale/.local/lib/node_modules/typescript/lib'
    }
  }
}
