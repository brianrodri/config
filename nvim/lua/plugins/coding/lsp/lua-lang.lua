return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = { library = { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
        optional = true,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts) opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "lua", "luadoc" }) end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = function(_, opts)
            opts = opts or {}
            opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, { "stylua" })
            return opts
        end,
    },
}
