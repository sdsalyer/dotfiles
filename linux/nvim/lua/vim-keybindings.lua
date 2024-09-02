vim.g.mapleader = " "

-- navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<cr>')
vim.keymap.set('n', '<c-j>', ':wincmd j<cr>')
vim.keymap.set('n', '<c-h>', ':wincmd h<cr>')
vim.keymap.set('n', '<c-l>', ':wincmd l<cr>')

-- Shift-tab to move left one &shiftwidth
vim.keymap.set('i', '<S-Tab>', '<C-d>');
-- un-highlight search results
vim.keymap.set('n', '<leader>h', ':nohlsearch<cr>')

-- Goto netrw (:Explore)
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Keep cursor in the middle
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

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
vim.keymap.set("n", "<leader>vsh", vim.lsp.buf.signature_help, {})
vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, {})
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, {})
vim.keymap.set("n", "<leader>[d", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "<leader>]d", vim.diagnostic.goto_prev, {})

