return {
    {
        "williamboman/mason-lspconfig.nvim",
        opts = { ensure_installed = { "markdownlint" } },
        opts_extend = { "ensure_installed" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "markdown", "markdown_inline" } },
        opts_extend = { "ensure_installed" },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = { ensure_installed = { "markdownlint" } },
        opts_extend = { "ensure_installed" },
    },
}
