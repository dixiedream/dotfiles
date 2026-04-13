local augroup = vim.api.nvim_create_augroup('Dixiedream', {})

local autocmd = vim.api.nvim_create_autocmd

autocmd('TextYankPost', {
  group = augroup,
  pattern = '*',
  callback = function()
    vim.hl.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

autocmd({ "BufWritePre" }, {
  group = augroup,
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

-- Auto-resize splits when window is resized
autocmd("VimResized", {
  group = augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Ansible Vault security measures
local vault_group = vim.api.nvim_create_augroup("VaultYmlSettings", { clear = true })
local vault_patterns = { "vault.yml", "*vault*.yml", "group_vars/*/vault.yml" }

autocmd({ "BufRead", "BufNewFile" }, {
  group = vault_group,
  pattern = vault_patterns,
  callback = function()
    vim.b._orig_clipboard = vim.o.clipboard
    vim.b._orig_shada = vim.o.shada

    vim.o.clipboard = ""
    vim.o.shada = ""
    vim.opt_local.undofile = false
  end,
})

autocmd("BufLeave", {
  group = vault_group,
  pattern = vault_patterns,
  callback = function()
    if vim.b._orig_clipboard then
      vim.o.clipboard = vim.b._orig_clipboard
    end
    if vim.b._orig_shada then
      vim.o.shada = vim.b._orig_shada
    end
    vim.opt_local.undofile = true
  end,
})
