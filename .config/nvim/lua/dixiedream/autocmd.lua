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

