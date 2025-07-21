" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" TODO: Load plugins here (pathogen or vundle)
runtime ftplugin/man.vim

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" TODO: Pick a leader key
" let mapleader = ","
let mapleader = " "

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
" map <leader><space> :let @/=''<cr> " clear search
map <leader>h :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
set t_Co=256
set background=dark
" Solarized
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1
"colorscheme solarized

" One-Dark
" https://github.com/joshdick/onedark.vim/raw/refs/heads/main/autoload/onedark.vim
" in ~/.vim/audoload/
" https://github.com/joshdick/onedark.vim/raw/refs/heads/main/colors/onedark.vim
" in ~/.vim/colors/
"
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
"if (empty($TMUX))
" if (has("nvim"))
" 	"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
" 	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
	set termguicolors
endif
"endif
colorscheme onedark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" b3rts additional updates:
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" netrw file browser options
" see: https://neovim.io/doc/user/pi_netrw.html#netrw-var

" Keep the current directory and the browsing directory synced.
" This helps you avoid the move files error.
let g:netrw_keepdir = 0

" Change the size of the Netrw window when it creates a split. I think 30% is fine.
let g:netrw_winsize = 30

" Hide the banner (if you want). To show it temporarily you can use I inside Netrw.
let g:netrw_banner = 0

"[[
"  g:netrw_liststyle  		Set the default listing style:
"                                = 0: thin listing (one file per line)
"                                = 1: long listing (one file per line with time
"				     stamp information and file size)
"				= 2: wide listing (multiple files in columns)
"				= 3: tree style listing
"
" g:netrw_sizestyle  		not defined: actual bytes (default)
"				="b" : actual bytes       (default)
"				="h" : human-readable (ex. 5k, 4m, 3g)
"				       uses 1000 base
"				="H" : human-readable (ex. 5K, 4M, 3G)
"				       uses 1024 base
"				The long listing (netrw-i) and query-file
"				maps (netrw-qf) will display file size
"				using the specified style.
"]]
let g:netrw_liststyle = 1
let g:getrw_sizestyle = "H"

" Key mapping to open Netrw
nmap <Leader>pv :Explore<CR>


" vim
set relativenumber
" draw a line at column
set colorcolumn=81,121 " ,161,241,321,401,481,561,641,721,801"


" code folding stuff
set foldmethod=syntax
set foldcolumn=1 "Set the fold column to 1
set foldtext=getline(v:foldstart) " Allow syntax highlighting on the first line of the fold
set foldlevel=99 " Set the minimum level of a fold that will be closed
set foldlevelstart=-1 " Top level folds are open, nested will be closed
set foldnestmax=9 " Set the maximum nesting level for folds
set fillchars+=fold: " Set fill characters for folds

set tags+=~/.tags

