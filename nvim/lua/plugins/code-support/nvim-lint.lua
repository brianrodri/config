---@module "lazy"
---@type LazySpec
return { -- Linting
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = lint.linters_by_ft or {}
        lint.linters_by_ft["markdown"] = { "markdownlint" }
        lint.linters_by_ft["typescript"] = { "eslint" }
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("lint", { clear = true }),
            callback = function()
                if vim.opt_local.modifiable:get() then lint.try_lint() end
            end,
        })
    end,
}
