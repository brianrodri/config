---@module "lazy"
---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = false, -- neo-tree handles lazy loading on its own.
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim",
  },
  keys = require("config.keymaps").set_neo_tree_keymaps,
  ---@module "neo-tree"
  ---@type neotree.Config
  opts = {},
}
