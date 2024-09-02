--vim.g.mapleader = " "
vim.g.background = "light"

vim.wo.number = true

vim.opt.swapfile = false
--vim.opt.backup = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
--vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

-- draw a line at column
vim.opt.colorcolumn = "81,121" -- ,161,241,321,401,481,561,641,721,801"
-- hi ColorColumn ctermbg=lightgrey guibg=lightgrey
vim.api.nvim_set_hl(0, "ColorColumn", {
    bg = "#1a1c1e",
})

-- turned this off in favor of <leader>y
-- use system clipboard
-- vim.opt.clipboard:append('unnamedplus')

-- Disable mouse
-- vim.keymap.set("", "<up>", "<nop>", { noremap = true })
-- vim.keymap.set("", "<down>", "<nop>", { noremap = true })
-- vim.keymap.set("i", "<up>", "<nop>", { noremap = true })
-- vim.keymap.set("i", "<down>", "<nop>", { noremap = true })
-- vim.opt.mousescroll = "ver:0,hor:0"
vim.opt.mouse = ""

-- disable extending comment on carriage return
-- default: "tcqj"
-- vim.cmd([[autocmd BufEnter * set formatoptions-=o]])
-- the below is correct but is overwritten by a rogue plugin, so I moved to autocmd
-- vim.opt.formatoptions:remove({'c', 'r', 'o'})

-- code folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "1"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = -1
vim.opt.foldnestmax = 9
vim.opt.fillchars:append({ fold = '󰑀' })

-- character replacements
vim.opt.list = true
vim.opt.listchars = {
    eol = '󰌑',
    tab = ' ',
    trail = '󱁐',
    nbsp = '+',
    extends = '>',
    precedes = '<',
    -- space = '_'
}

-- colors for whitespace, etc.
vim.api.nvim_set_hl(0, "Whitespace", {
    fg = "#41454e",
    blend = 50,
})

vim.api.nvim_set_hl(0, "SpecialKey", {
    fg = "#41454e",
    blend = 50,
})
