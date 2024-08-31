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

vim.opt.hlsearch = true
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
    --fg = "#41454e",
    bg = "#1a1c1e",
    blend = 0,
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


-- code folding via treesitter (via LSP is inconsistent?)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "1"
vim.opt.foldtext = ""      -- allows syntax highlighting on first line of fold
vim.opt.foldlevel = 99     -- the minimum level of a fold that will be closed
vim.opt.foldlevelstart = -1 -- top level folds are open, nested will be closed
vim.opt.foldnestmax = 9    -- ? no nesting beyond 4 levels (default: 20)
vim.opt.fillchars:append({ fold = "" }) -- chars indicating a code fold

-- character replacements
vim.opt.list = true
-- default: listchars=tab:> ,trail:-,nbsp:+
-- vim.opt.listchars = eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
vim.opt.listchars = {
    eol      = '¬',
    --eol      = '↲',
    tab      = '▸ ',
    trail    = '␣',
    nbsp     = '+',
    extends  = '>',
    precedes = '<',
    --space       = '·'
    --space       = '␣'
}

-- colors for whitespace etc. -- not sure `blend` is doing anything
vim.api.nvim_set_hl(0, "Whitespace", { -- tabs, spaces, etc.
    fg = "#41454e",
    blend = 50,
})

vim.api.nvim_set_hl(0, "SpecialKey", { -- non-printable characters
    fg = "#41454e",
    blend = 50,
})
