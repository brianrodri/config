local lint = require("lint")
lint.linters_by_ft = vim.tbl_deep_extend("force", lint.linters_by_ft or {}, {
  javascript = { "eslint" },
  typescript = { "eslint" },
})

vim.lsp.enable("ts_ls")
