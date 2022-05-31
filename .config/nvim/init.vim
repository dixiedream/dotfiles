"""""""""""" VimPlug - Vim plugin manager """""""""""""""""""
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
" Status bar
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

Plug 'ap/vim-css-color'

" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'mbbill/undotree'

" Telescope
Plug 'nvim-lua/plenary.nvim' 
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make' }

" LSP
Plug 'neovim/nvim-lspconfig'
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

au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufEnter *.org            call org#SetOrgFileType()

