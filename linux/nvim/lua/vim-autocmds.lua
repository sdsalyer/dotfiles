-- highlight text on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
  end,
})

-- disable continuing comments on next line
vim.api.nvim_create_autocmd("BufEnter", {
--vim.api.nvim_create_autocmd("OptionSet", {
    group = vim.api.nvim_create_augroup('format_options', {}),
    desc = 'Disable comment continuation on next line',
    -- pattern = "formatoptions",
    pattern = '*',
    callback = function()
        vim.opt.formatoptions:remove({'c', 'r', 'o'})
    end
})
