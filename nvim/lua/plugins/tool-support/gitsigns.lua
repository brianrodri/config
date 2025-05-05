---@module "lazy"
---@type LazySpec
return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  "lewis6991/gitsigns.nvim",
  ---@module "gitsigns.config"
  ---@type Gitsigns.Config
  ---@diagnostic disable: missing-fields
  opts = {
    attach_to_untracked = true,
    watch_gitdir = { enable = true },
  },
}
