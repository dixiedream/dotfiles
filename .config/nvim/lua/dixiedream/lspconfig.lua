local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    --buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local nvim_lsp = require('lspconfig')

-- GoLang
nvim_lsp.gopls.setup{
    on_attach = on_attach
}

-- Lua
nvim_lsp.sumneko_lua.setup {
  -- settings = {
  --   Lua = {
  --     runtime = {
  --       -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
  --       version = 'LuaJIT',
  --     },
  --     diagnostics = {
  --       -- Get the language server to recognize the `vim` global
  --       globals = {'vim'},
  --     },
  --     workspace = {
  --       -- Make the server aware of Neovim runtime files
  --       library = vim.api.nvim_get_runtime_file("", true),
  --     },
  --     -- Do not send telemetry data containing a randomized but unique identifier
  --     telemetry = {
  --       enable = false,
  --     },
  --   },
  -- },
  on_attach = on_attach
}

-- PHP
nvim_lsp.intelephense.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { 'php' }
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
    filetypes = { 'vue' }
}
