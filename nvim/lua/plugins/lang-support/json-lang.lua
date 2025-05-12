---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "yaml" } },
    opts_extend = { "ensure_installed" },
  },

  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { json = { "prettier" } } },
  },
}
