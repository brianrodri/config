---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "json" } },
    opts_extend = { "ensure_installed" },
  },

  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { json = { "prettier" } } },
  },

  {
    "neovim/nvim-lspconfig",
    ---@type my.LspConfig
    opts = { jsonls = {} },
  },

  {
    "mfussenegger/nvim-lint",
    ---@type my.LintOpts
    opts = { linters_by_ft = { json = { "jsonlint" } } },
  },
}
