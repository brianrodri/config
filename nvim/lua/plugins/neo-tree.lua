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
  ---@module "neo-tree"
  ---@type neotree.Config
  opts = {
    close_if_last_window = true,
    filesystem = {
      group_empty_dirs = true,
      follow_current_file = { enabled = true, leave_dirs_open = true },
    },
    buffers = {
      follow_current_file = { enabled = true, leave_dirs_open = true },
    },
  },
}
