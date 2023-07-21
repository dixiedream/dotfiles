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
   -- use 'shaunsingh/nord.nvim',
   'folke/tokyonight.nvim',
   -- Status bar
   'nvim-lualine/lualine.nvim',
   'lewis6991/impatient.nvim',

   -- Dev stuff (telescope, lsp, highlighting, autocompletion)
   'windwp/nvim-autopairs',
   'nvim-lua/plenary.nvim',
   { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
   { 'nvim-telescope/telescope.nvim', tag = '0.1.2', dependencies = 'nvim-lua/plenary.nvim'},
   --
   'neovim/nvim-lspconfig',
   --
   { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
   --
   'hrsh7th/nvim-cmp',
   'hrsh7th/cmp-nvim-lsp',
   'hrsh7th/cmp-buffer',
   'hrsh7th/cmp-path',
   --
   'L3MON4D3/LuaSnip',
   'saadparwaiz1/cmp_luasnip',
   --
   'numToStr/Comment.nvim',
   --
   { 'ThePrimeagen/harpoon', dependencies = 'nvim-lua/plenary.nvim' },
 }

local opts = {}
require("lazy").setup(plugins, opts)
