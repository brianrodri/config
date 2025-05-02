return {
    "saghen/blink.cmp",
    event = "VimEnter",
    version = "1.*",
    dependencies = {
        "folke/lazydev.nvim",
        "MahanRahmati/blink-nerdfont.nvim",
    },
    opts = {
        appearance = { nerd_font_variant = "mono" },
        completion = { documentation = { auto_show = true, auto_show_delay_ms = 500 } },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        keymap = { preset = "default" },
        sources = {
            default = {
                "lsp",
                "path",
                "buffer",
                "lazydev",
                "nerdfont",
            },
            providers = {
                lazydev = { module = "lazydev.integrations.blink" },
                nerdfont = { module = "blink-nerdfont" },
            },
        },
    },
    opts_extend = { "sources.default" },
}
