-- LSP
vim.lsp.enable("ts_ls")

-- Lint
local ok, lint = pcall(require, "lint")
if not ok then return vim.notify("config.lsp.markdown-lang called before lint setup", "error") end
lint.linters_by_ft = vim.tbl_deep_extend("force", lint.linters_by_ft or {}, { typescript = { "eslint" } })
