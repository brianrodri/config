---@module "lazy"
---@type LazySpec
return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    ---@module "noice"
    ---@type NoiceConfig
    ---@diagnostic disable: missing-fields
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",

      {
        "nvim-treesitter/nvim-treesitter",
        opts = { ensure_installed = { "bash" } },
        opts_extend = { "ensure_installed" },
      },
    },
  },
}
