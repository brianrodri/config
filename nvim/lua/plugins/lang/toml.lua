---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "toml" } },
    opts_extend = { "ensure_installed" },
  },

  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { toml = { "prettier" } } },
  },

  {
    "neovim/nvim-lspconfig",
    ---@type my.LspConfig
    opts = { taplo = {} },
  },
}
