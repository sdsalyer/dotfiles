" options and whatnot
" Don't try to be vi compatible
set nocompatible

" Helps force plugins to load correctly when it is turned back on below
filetype off

" Load plugins here (pathogen or vundle)
runtime ftplugin/man.vim
"runtime! plugin/**/*.vim

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

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

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
set list " To enable by default

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


" vim
set relativenumber


" code folding stuff
set foldmethod=syntax
set foldcolumn=1 "Set the fold column to 1
set foldtext=getline(v:foldstart) " Allow syntax highlighting on the first line of the fold
set foldlevel=99 " Set the minimum level of a fold that will be closed
set foldlevelstart=-1 " Top level folds are open, nested will be closed
set foldnestmax=9 " Set the maximum nesting level for folds
set fillchars+=fold: " Set fill characters for folds

set tags+=~/.tags

