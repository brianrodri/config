return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = { library = { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
        optional = true,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { "lua", "luadoc" },
        opts_extend = { "ensure_installed" },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = { ensure_installed = { "stylua" } },
        opts_extend = { "ensure_installed" },
    },
}
