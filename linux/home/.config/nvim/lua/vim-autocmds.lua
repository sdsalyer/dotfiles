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

-- set highlight column when colorscheme changes
vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('colorscheme_change', {}),
    desc = 'Change highlight column when colorscheme changes',
    pattern = 'base16*',
    callback = function()
        local bgcolor = "#"..vim.g.base16_gui01
        print("ColorScheme: " .. vim.fn.expand("<amatch>").. " | ColorColumn: " .. bgcolor)
        vim.api.nvim_set_hl(0, "ColorColumn", {
            bg = bgcolor
        })
    end,
})

