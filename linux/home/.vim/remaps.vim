" remaps / keybindings

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>


" Pick a leader key
let mapleader = " "

" clear search highlights
map <leader>h :let @/=''<cr>

" Formatting
map <leader>q gqip

" Toggle tabs and EOL
map <leader>l :set list!<CR>

" Key mapping to open Netrw
nmap <Leader>pv :Explore<CR>

