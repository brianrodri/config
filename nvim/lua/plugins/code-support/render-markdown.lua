---@module "lazy"
---@type LazySpec
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
  ---@module "render-markdown"
  ---@type render.md.UserConfig
  opts = { preset = "obsidian" },
}
