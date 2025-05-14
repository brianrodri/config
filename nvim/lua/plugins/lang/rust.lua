---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "rust", "ron" } },
    opts_extend = { "ensure_installed" },
  },

  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { rust = { "rustfmt" } } },
  },

  {
    "nvim-neotest/neotest",
    dependencies = { "rouge8/neotest-rust" },
    opts = { adapters = { ["neotest-rust"] = {} } },
  },

  {
    "neovim/nvim-lspconfig",
    ---@type my.LspConfig
    opts = { rust_analyzer = {} },
  },

  {
    "mfussenegger/nvim-lint",
    ---@type my.LintOpts
    opts = { linters_by_ft = { rust = { "clippy" } } },
  },

  {
    "ahmedkhalf/project.nvim",
    ---@module "project_nvim"
    ---@type ProjectOptions
    opts = { patterns = { "Cargo.toml" } },
    opts_extend = { "patterns" },
  },
}
