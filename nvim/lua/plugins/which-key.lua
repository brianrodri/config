---@module "lazy"
---@type LazySpec
return {
  "folke/which-key.nvim",
  ---@module "which-key"
  ---@class wk.Opts
  opts = {
    preset = "helix",
    keys = { scroll_down = "<c-n>", scroll_up = "<c-p>" },
  },
}
