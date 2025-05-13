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

  { -- Telescope extension for searching LSP JSON fields
    "nvim-telescope/telescope.nvim",
    dependencies = { "Myzel394/jsonfly.nvim" },
    opts = { extensions = { jsonfly = {} } },
    -- stylua: ignore
    -- luacheck: no max line length
    keys = {
      { "<leader>so", function() require("telescope").extensions.jsonfly.jsonfly() end, desc = "Search LSP Options", ft = { "json", "xml", "yaml", "toml" }, mode = { "n" } },
    },
  },
}
