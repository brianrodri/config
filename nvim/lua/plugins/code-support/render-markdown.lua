---@module "lazy"
---@type LazySpec
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        highlight = { enable = true },
        ensure_installed = { "markdown", "markdown_inline", "latex", "html", "typst", "yaml" },
      },
      opts_extend = { "ensure_installed" },
    },
  },
  ---@module "render-markdown"
  ---@type render.md.UserConfig
  opts = { preset = "obsidian" },
}
