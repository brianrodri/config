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
    keywords = { IMPORTANT = { icon = " ", color = "warning" } },
    highlight = { pattern = { [[.{-}<(\s?(KEYWORDS)):]], [[.{-}<(\s?(KEYWORDS)\(.{-}\)):]] } },
    search = { pattern = "\\b(KEYWORDS)(:|\\()" },
  },
}
