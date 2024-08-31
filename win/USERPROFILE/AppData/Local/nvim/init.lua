--[[
	██          ██   ██       ██
	░░          ░░   ░██      ░██
	██ ███████  ██ ██████    ░██ ██   ██  ██████
	░██░░██░░░██░██░░░██░     ░██░██  ░██ ░░░░░░██
	░██ ░██  ░██░██  ░██      ░██░██  ░██  ███████
	░██ ░██  ░██░██  ░██   ██ ░██░██  ░██ ██░░░░██
	░██ ███  ░██░██  ░░██ ░██ ███░░██████░░████████
	░░ ░░░   ░░ ░░    ░░  ░░ ░░░  ░░░░░░  ░░░░░░░░
--]]

require("netrw-options")
require("vim-autocmds")
require("vim-keybindings")


-- clone lazy if it isn't already available
-- lazypath = ~/.localshare/nvim -- see :help standard-path
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    print("--> first load: cloning lazy")
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- require it
require("lazy").setup("plugins")

-- ensure my options take precedence
require("vim-options")
