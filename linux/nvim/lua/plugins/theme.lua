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
    --         --[[
    --             Catppuccin theme
    --                 - latte
    --                 - macchiato
    --                 - mocha
    --                 - idk what
    --         --]]
    --         vim.cmd.colorscheme "catppuccin-macchiato"
    --     end
    -- }
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- https://github.com/scottmckendry/cyberdream.nvim
            require("cyberdream").setup({
                transparent = true,
                italic_comments = false,
                -- Replace all fillchars with ' ' for the ultimate clean look
                hide_fillchars = true,
                borderless_telescope = true,
                -- Set terminal colors used in `:terminal`
                terminal_colors = true,
            })


            -- Lastly, tell vim to use it
            vim.cmd.colorscheme "cyberdream"
        end
    }
}
