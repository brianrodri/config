---@module "lazy"
---@type LazySpec
return { -- Linting
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
}
