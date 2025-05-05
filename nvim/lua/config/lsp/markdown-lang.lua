vim.lsp.enable("markdown_oxide")

vim.lsp.config("markdown_oxide", {
    root_markers = { ".obsidian" },
    on_attach = require("config.keymaps").set_obsidian_keymaps,
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
})
