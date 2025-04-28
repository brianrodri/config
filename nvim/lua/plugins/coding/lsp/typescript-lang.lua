return {
    { "neovim/nvim-lspconfig", opts = { servers = { vtsls = {} } } },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = function(_, opts)
            opts = opts or {}
            opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "eslint", "prettier" })
            return opts
        end,
    },
}
