" Copy to register remap
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nmap <leader>Y "+Y

" Shout out init vim config 
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>

" paste something and keep it available for further pasting.
xnoremap <leader>p "_dP 

" Open explorer then d to create directory % to create file
nnoremap <leader>pv :Ex<cr>

" Split window management
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>rp :resize 100<CR>

" Exit from insert mode with CTRL C
inoremap <C-c> <esc>
