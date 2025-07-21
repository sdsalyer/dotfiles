--[[
    Theme
--]]
return {
    -- {
    --     "catppuccin/nvim",
    --     lazy = false,
    --     name = "catppuccin",
    --     priority = 1000,
    --     config = function()
    --         -- latte
    --         -- macchiato
    --         -- mocha
    --         -- idk what
    --         vim.cmd.colorscheme "catppuccin-macchiato"
    --     end
    -- }
    -- {
    --     -- https://github.com/scottmckendry/cyberdream.nvim?tab=readme-ov-file#%EF%B8%8F-configuring
    --     "scottmckendry/cyberdream.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("cyberdream").setup({})
    --         vim.cmd.colorscheme "cyberdream"
    --     end
    -- }
    -- {
    --     "RRethy/base16-nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("base16-colorscheme")
    --         -- .setup({})
    --         -- .with_config({
    --             -- telescope = true,
    --             -- indentblankline = true,
    --             -- notify = true,
    --             -- ts_rainbow = true,
    --             -- cmp = true,
    --             -- illuminate = true,
    --             -- dapui = true,
    --         -- })({})
    --         vim.cmd('colorscheme base16-gruvbox-dark-soft')
    --     end
    -- }
    {
        "tinted-theming/base16-vim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd('colorscheme base16-outrun-dark')
        end
    }

}


