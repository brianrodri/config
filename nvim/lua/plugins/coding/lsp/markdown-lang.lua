return {
    { "williamboman/mason-lspconfig.nvim", opts = { ensure_installed = { "markdownlint" } } },
    { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "markdown", "markdown_inline" } } },
}
