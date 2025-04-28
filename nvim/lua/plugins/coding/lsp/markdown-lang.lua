return {
    { "williamboman/mason-lspconfig.nvim", opts = { ensure_installed = { "markdownlint" } } },
    { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "markdown", "markdown_inline" } } },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = function(_, opts)
            opts = opts or {}
            opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "markdownlint" })
            return opts
        end,
    },
}
