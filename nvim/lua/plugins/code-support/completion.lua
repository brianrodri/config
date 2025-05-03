return {
    "saghen/blink.cmp",
    event = "VimEnter",
    version = "1.*",
    opts = {
        sources = {
            default = { "lsp", "path", "buffer" },
        },
    },
    opts_extend = { "sources.default" },
}
