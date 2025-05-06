---@module "lazy"
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  ---@module "nvim-treesitter"
  ---@type TSConfig
  ---@diagnostic disable: missing-fields
  opts = {
    highlight = { enable = true },
  },
}
