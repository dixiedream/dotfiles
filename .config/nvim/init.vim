""""""""""" VimPlug - Vim plugin manager """""""""""""""""""
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
" Colorscheme
Plug 'shaunsingh/nord.nvim'

" Status bar
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

Plug 'ap/vim-css-color'

" Telescope
Plug 'nvim-lua/plenary.nvim' 
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make' }

" LSP
Plug 'neovim/nvim-lspconfig'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

call plug#end()

let mapleader = " "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Configs imports
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('dixiedream')

syntax enable   
let g:rehash256 = 1
let g:minimap_highlight='Visual'
let g:python_highlight_all = 1

