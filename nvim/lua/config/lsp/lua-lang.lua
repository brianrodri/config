-- LSP
vim.lsp.enable("lua_ls")

-- Lint
local ok, lint = pcall(require, "lint")
if not ok then return vim.notify('require("lint") error', vim.log.levels.ERROR) end
lint.linters_by_ft = vim.tbl_deep_extend("force", lint.linters_by_ft or {}, { markdown = { "luacheck" } })
