return {
    { -- Configures LuaLS for editing Neovim config files
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
        init = function() vim.lsp.enable("lua_ls") end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "lua", "luadoc" } },
        opts_extend = { "ensure_installed" },
    },

    {
        "saghen/blink.cmp",
        opts = {
            sources = {
                default = { "lazydev" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
        },
        opts_extend = { "sources.default" },
    },
}
