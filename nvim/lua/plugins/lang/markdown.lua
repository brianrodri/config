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
    opts = {
      preset = "obsidian",
      bullet = { icons = { "󰍴 " }, right_pad = 0, highlight = "@comment" },
      checkbox = {
        right_pad = 0,
        checked = { icon = "󰄵 ", highlight = "@text.todo.checked", scope_highlight = "@markup.strikethrough" },
        unchecked = { icon = "󰄱 ", highlight = "@text.todo.unchecked" },
        -- stylua: ignore
        -- luacheck: no max line length
        custom = {
          todo = { raw = "[-]", rendered = "󰛲 ", highlight = "@error", scope_highlight = "@markup.strikethrough" },
          mood = { raw = "[=]", rendered = "󰋓 ", highlight = "Purple", scope_highlight = "PurpleItalic" },
        },
      },
    },
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
