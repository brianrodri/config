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
    opts = function(_, opts)
      return vim.tbl_extend("keep", opts or {}, { adapters = { require("neotest-vitest") } })
    end,
  },
}
