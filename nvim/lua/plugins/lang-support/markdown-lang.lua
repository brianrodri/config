return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true },
      ensure_installed = { "markdown", "markdown_inline", "yaml" },
    },
    opts_extend = { "ensure_installed" },
  },

  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { markdown = { "markdownlint" } } },
  },
}
