local opts = { noremap = true, silent = true }

-- Shorten function
local keymap = vim.api.nvim_set_keymap

-- Leader set
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Easier moving between splits
keymap("n", "<C-j>", "<C-w><C-j>", opts)
keymap("n", "<C-k>", "<C-w><C-k>", opts)
keymap("n", "<C-l>", "<C-w><C-l>", opts)
keymap("n", "<C-h>", "<C-w><C-h>", opts)
keymap("n", "q:", "<nop>", opts) -- Disable the command history!!
keymap("n", "Q", "<nop>", opts) -- Disable the command history!!

-- Split window management
keymap("n", "<leader>+", ":vertical resize +5<cr>", opts)
keymap("n", "<leader>-", ":vertical resize -5<cr>", opts)

-- Open explorer
keymap("n", "<leader>pv", ":Ex<cr>", opts)

-- Exit from insert mode with CTRL C
keymap("i", "<C-c>", "<esc>", opts)

-- Copy to register
keymap("v", "<leader>y", "\"+y", opts)
keymap("n", "<leader>y", "\"+y", opts)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", "\"_dP")
