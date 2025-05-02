return {
    { "neovim/nvim-lspconfig", opts = { servers = { vtsls = {} } } },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = { ensure_installed = { "eslint", "prettier" } },
        opts_extend = "ensure_installed",
    },
}
