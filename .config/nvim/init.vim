""""""""""" VimPlug - Vim plugin manager """""""""""""""""""
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
" Colorscheme
Plug 'shaunsingh/nord.nvim'

" Status bar
Plug 'nvim-lualine/lualine.nvim'

Plug 'ap/vim-css-color'

" Dev stuff (telescope, lsp, highlighting, autocompletion)
Plug 'nvim-lua/plenary.nvim' 
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make' }
"
Plug 'neovim/nvim-lspconfig'
"
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
"
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
"
Plug 'numToStr/Comment.nvim'
"
Plug 'ThePrimeagen/harpoon'

call plug#end()

let mapleader = " "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Configs imports
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('dixiedream')

syntax enable   

