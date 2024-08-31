return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Mason
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- Completion framework:
        "hrsh7th/nvim-cmp",

        -- LSP completion source:
        "hrsh7th/cmp-nvim-lsp",

        -- Useful completion sources:
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/vim-vsnip",

        -- lua snip
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",

        -- idk wut
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                --"gopls",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["jdtls"] = {},

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        -- local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            -- snippet = {
            --     expand = function(args)
            --         require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            --     end,
            -- },
            -- mapping = cmp.mapping.preset.insert({
            --     ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
            --     ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
            --     ["<C-y>"] = cmp.mapping.confirm({ select = true }),
            --     ["<C-Space>"] = cmp.mapping.complete(),
            -- }),
            -- sources = cmp.config.sources({
            --     { name = "nvim_lsp" },
            --     { name = "luasnip" }, -- For luasnip users.
            -- }, {
            --     { name = "buffer" },
            -- })
            -- Enable LSP snippets
            snippet = {
                expand = function(args)
                    --vim.fn["vsnip#anonymous"](args.body)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                -- Add tab support
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                -- ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                })
            },
            -- Installed sources:
            sources = {
                { name = "path" },                                       -- file paths
                { name = "nvim_lsp",               keyword_length = 3 }, -- from language server
                { name = "nvim_lsp_signature_help" },                    -- display function signatures with current parameter emphasized
                { name = "nvim_lua",               keyword_length = 2 }, -- complete neovim"s Lua runtime API such vim.lsp.*
                { name = "buffer",                 keyword_length = 2 }, -- source current buffer
                { name = "vsnip",                  keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
                { name = "luasnip",                keyword_length = 2 }, -- For luasnip users.
                { name = "calc" },                                       -- source for math calculation
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                fields = { "menu", "abbr", "kind" },
                format = function(entry, item)
                    local menu_icon = {
                        nvim_lsp = "λ",
                        vsnip = "⋗",
                        buffer = "Ω",
                        path = "🖫",
                    }
                    item.menu = menu_icon[entry.source.name]
                    return item
                end,
            },
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "BORG",
                prefix = "",
            },
        })
    end
}
