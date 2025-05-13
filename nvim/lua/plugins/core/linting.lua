---@class my.LintOpts
---@field linters_by_ft { [string]: string[] }

---@module "lazy"
---@type LazySpec
return { -- Linting
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  ---@param opts my.LintOpts
  config = function(_, opts) require("lint").linters_by_ft = vim.tbl_get(opts or {}, "linters_by_ft") or {} end,
}
