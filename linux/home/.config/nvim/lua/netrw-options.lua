-- netrw file browser options
-- see: https://neovim.io/doc/user/pi_netrw.html#netrw-var
--


-- Keep the current directory and the browsing directory synced.
-- This helps you avoid the move files error.
-- let g:netrw_keepdir = 0
vim.g.netrw_keepdir = false

-- Change the size of the Netrw window when it creates a split. I think 30% is fine.
-- let g:netrw_winsize = 30
vim.g.netrw_winsize = 30

-- Hide the banner (if you want). To show it temporarily you can use I inside Netrw.
-- let g:netrw_banner = 0
vim.g.netrw_banner = false

--[[
  g:netrw_liststyle  		Set the default listing style:
                                = 0: thin listing (one file per line)
                                = 1: long listing (one file per line with time
				     stamp information and file size)
				= 2: wide listing (multiple files in columns)
				= 3: tree style listing

 g:netrw_sizestyle  		not defined: actual bytes (default)
				="b" : actual bytes       (default)
				="h" : human-readable (ex. 5k, 4m, 3g)
				       uses 1000 base
				="H" : human-readable (ex. 5K, 4M, 3G)
				       uses 1024 base
				The long listing (netrw-i) and query-file
				maps (netrw-qf) will display file size
				using the specified style.
--]]
vim.g.netrw_liststyle = 1
vim.g.getrw_sizestyle = "H"
