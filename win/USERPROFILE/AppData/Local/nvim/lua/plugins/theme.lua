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
    {
        -- https://github.com/scottmckendry/cyberdream.nvim?tab=readme-ov-file#%EF%B8%8F-configuring
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("cyberdream").setup({})
            vim.cmd.colorscheme "cyberdream"
        end
    }
}
