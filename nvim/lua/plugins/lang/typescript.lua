---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "typescript" } },
    opts_extend = { "ensure_installed" },
  },

  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { javascript = { "prettier" }, typescript = { "prettier" } } },
  },

  {
    "nvim-neotest/neotest",
    dependencies = { "marilari88/neotest-vitest" },
    opts = { adapters = { ["neotest-vitest"] = {} } },
  },

  {
    "neovim/nvim-lspconfig",
    ---@type my.LspConfig
    opts = { ts_ls = {} },
  },

  {
    "mfussenegger/nvim-lint",
    ---@type my.LintOpts
    opts = { linters_by_ft = { typescript = { "eslint" } } },
  },

  {
    "brianrodri/projects.nvim",
    ---@module "projects"
    ---@type v1.ProjectOptions
    opts = { patterns = { "package.json" } },
    opts_extend = { "patterns" },
  },
}
