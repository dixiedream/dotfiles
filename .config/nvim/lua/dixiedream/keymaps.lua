-- vim.keymap.set('n', '<leader>1', function() harpoonUI.nav_file(1) end, {desc = "Go to file 1", silent = true, noremap = true })
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
keymap("n", "<C-j>", "<C-w>j>", opts)
keymap("n", "<C-k>", "<C-w>k>", opts)
keymap("n", "<C-l>", "<C-w>l>", opts)
keymap("n", "<C-h>", "<C-w>h>", opts)

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

-- TERMINAL --
-- Make esc leave the terminal mode
keymap("t", "<leader><esc>", "<C-\\><C-n>", term_opts)
keymap("t", "<esc><esc>", "<C-\\><C-n>", term_opts)
