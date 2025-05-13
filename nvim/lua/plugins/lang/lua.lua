---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "lua", "luadoc" } },
    opts_extend = { "ensure_installed" },
  },

  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { lua = { "stylua" } } },
  },

  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-neotest/neotest-plenary" },
    opts = { adapters = { ["neotest-plenary"] = {} } },
  },

  { -- Configures LuaLS for editing Neovim config files
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",

      {
        "saghen/blink.cmp",
        opts = {
          sources = {
            default = { "lazydev" },
            providers = {
              lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                score_offset = 100,
              },
            },
          },
        },
        opts_extend = { "sources.default" },
      },
    },
    ---@module "lazydev"
    ---@type lazydev.Config
    ---@diagnostic disable: missing-fields
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    ---@type my.LspConfig
    opts = { lua_ls = {} },
  },

  {
    "mfussenegger/nvim-lint",
    ---@type my.LintOpts
    opts = { linters_by_ft = { lua = { "luacheck" } } },
  },
}
