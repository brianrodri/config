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
  keys = {
    {
      "<leader>nf",
      function() require("neo-tree.command").execute({ source = "filesystem", toggle = true, reveal = true }) end,
      desc = "Open File System Tree",
    },
    {
      "<leader>nb",
      function() require("neo-tree.command").execute({ source = "buffers", toggle = true, reveal = true }) end,
      desc = "Open Buffers Tree",
    },
    {
      "<leader>ng",
      function() require("neo-tree.command").execute({ source = "git_status", toggle = true, reveal = true }) end,
      desc = "Open Git Status Tree",
    },
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
