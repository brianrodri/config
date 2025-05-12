---@module "lazy"
---@type LazySpec
return {
  "stevearc/oil.nvim",
  ---@module "oil"
  ---@type oil.SetupOpts
  opts = {
    watch_for_changes = true,
    view_options = {
      show_hidden = true,
      natural_order = true,
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  keys = {
    { "-", function() require("oil").open_float() end, { desc = "Open Parent Directory" } },
  },
}
