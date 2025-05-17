---@module "lazy"
---@type LazySpec
return {
  "folke/todo-comments.nvim",
  event = "VimEnter",
  dependencies = { "nvim-lua/plenary.nvim" },
  ---@module "todo-comments"
  ---@type TodoOptions
  ---@diagnostic disable: missing-fields
  opts = {
    signs = false,
    highlight = { pattern = ".*<(KEYWORDS)\\s*[:\\(]" },
    search = { pattern = "\\b(KEYWORDS)[:\\(]" },
  },
}
