vim.g.mapleader = " "

-- don't
-- Q - Repeat the last recorded register [count] times.
vim.keymap.set('n', 'Q', '<nop>')

-- navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<cr>')
vim.keymap.set('n', '<c-j>', ':wincmd j<cr>')
vim.keymap.set('n', '<c-h>', ':wincmd h<cr>')
vim.keymap.set('n', '<c-l>', ':wincmd l<cr>')

-- Goto netrw (:Explore)
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Shift+Tab to move left one &shiftwidth
vim.keymap.set('i', '<S-Tab>', '<C-d>');

-- un-highlight search results
vim.keymap.set('n', '<leader>h', ':nohlsearch<cr>')

-- move highlighted text up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Keep cursor in the middle
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- don't yank on paste
vim.keymap.set('x', '<leader>p', '\"_dP')

-- don't move cursor on join
vim.keymap.set('n', 'J', 'mzJ`z')

-- separate vim clipboard from system clipboard
vim.keymap.set('n', '<leader>y', "\"+y")
vim.keymap.set('v', '<leader>y', "\"+y")
vim.keymap.set('n', '<leader>Y', "\"+Y")

-- lsp 
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, {})
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, {})
vim.keymap.set("n", "<leader>vsh", vim.lsp.buf.signature_help, {})
vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, {})
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, {})
vim.keymap.set("n", "<leader>[d", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "<leader>]d", vim.diagnostic.goto_prev, {})

