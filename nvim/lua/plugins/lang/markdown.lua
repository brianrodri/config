---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true },
      ensure_installed = { "markdown", "markdown_inline" },
    },
    opts_extend = { "ensure_installed" },
  },

  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { markdown = { "prettier" } } },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
    ---@module "render-markdown"
    ---@type render.md.UserConfig
    opts = { preset = "obsidian" },
  },

  {
    "neovim/nvim-lspconfig",
    ---@type my.LspConfig
    opts = {
      markdown_oxide = {
        root_markers = { ".obsidian" },
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    ---@type my.LintOpts
    opts = { linters_by_ft = { markdown = { "markdownlint" } } },
  },
}
