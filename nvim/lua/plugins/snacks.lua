return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@module "snacks"
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            explorer = { enabled = true },
            image = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
            picker = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "css",
                "html",
                "javascript",
                "latex",
                "norg",
                "regex",
                "scss",
                "svelte",
                "tsx",
                "typst",
                "vue",
            },
        },
        opts_extend = { "ensure_installed" },
    },
}
