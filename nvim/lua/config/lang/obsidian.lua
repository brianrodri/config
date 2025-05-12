vim.lsp.enable("markdown_oxide")

vim.lsp.config("markdown_oxide", {
  root_markers = { ".obsidian" },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
})
