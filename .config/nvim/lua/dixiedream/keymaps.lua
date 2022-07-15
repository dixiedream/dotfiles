local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function
--local keymap = vim.keymaps.set
local keymap = vim.api.nvim_set_keymap

-- Leader set
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- NORMAL --
-- Easier moving between splits
keymap("n", "<C-j>", "<C-w><C-j>", opts)
keymap("n", "<C-k>", "<C-w><C-k>", opts)
keymap("n", "<C-l>", "<C-w><C-l>", opts)
keymap("n", "<C-h>", "<C-w><C-h>", opts)
keymap("n", "q:", "<nop>", opts) -- Disable the command history!!

-- Split window management
keymap("n", "<leader>+", ":vertical resize +5<cr>", opts)
keymap("n", "<leader>-", ":vertical resize -5<cr>", opts)

-- Open explorer
keymap("n", "<leader>pv", ":Ex<cr>", opts)

-- Copy to register
keymap("n", "<leader>y", "\"+y", opts)

-- INSERT --
-- Exit from insert mode with CTRL C
keymap("i", "<C-c>", "<esc>", opts)

-- VISUAL --
keymap("v", "<leader>y", "\"+y", opts)

