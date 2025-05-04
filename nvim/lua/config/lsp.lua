vim.lsp.enable({
    "lua_ls",
    "markdown_oxide",
})

vim.lsp.config("markdown_oxide", {
    root_markers = { ".obsidian" },
    on_attach = function(client, bufnr) require("config.keymaps").set_obsidian_keymaps(client, bufnr) end,
    capabilities = {
        workspace = { didChangeWatchedFiles = { dynamicRegistration = true } },
    },
})
