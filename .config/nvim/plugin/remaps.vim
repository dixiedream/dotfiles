" Copy to register remap
nnoremap <leader>y "+y
vnoremap <leader>y "+y

" Open explorer then d to create directory % to create file, R to rename
nnoremap <leader>pv :Ex<cr>

" Split window management
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>
" Easier Moving between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Exit from insert mode with CTRL C
inoremap <C-c> <esc>

if has('nvim')
    " Make esc leave terminal mode
    tnoremap <leader><Esc> <C-\><C-n>
    tnoremap <Esc><Esc> <C-\><C-n>
endif
