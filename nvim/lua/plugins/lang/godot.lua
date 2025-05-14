---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "gdscript" } },
    opts_extend = { "ensure_installed" },
  },

  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { gdscript = { "gdformat" } } },
  },

  {
    "neovim/nvim-lspconfig",
    ---@type my.LspConfig
    opts = { gdscript = {} },
  },

  {
    "mfussenegger/nvim-lint",
    ---@type my.LintOpts
    opts = { linters_by_ft = { gdscript = { "gdlint" } } },
  },

  {
    "ahmedkhalf/project.nvim",
    ---@module "project_nvim"
    ---@type ProjectOptions
    opts = { patterns = { "project.godot" } },
    opts_extend = { "patterns" },
  },
}
