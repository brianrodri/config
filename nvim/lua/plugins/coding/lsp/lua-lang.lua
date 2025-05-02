return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = { library = { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
        optional = true,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "lua", "luadoc" } },
        opts_extend = { "ensure_installed" },
    },
}
