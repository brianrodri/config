local my_obsidian = require("config.integ.obsidian")

---@module "lazy"
---@type LazySpec
return {
  "brianrodri/obsidian.nvim",
  branch = "substitution-context",
  dependencies = { "nvim-lua/plenary.nvim" },
  ---@module "obsidian"
  ---@type obsidian.config.ClientOpts
  ---@diagnostic disable: missing-fields
  opts = {
    workspaces = { my_obsidian.personal_vault },
    ui = { enable = false },
  },
  keys = {
    { "<leader>no", my_obsidian.action.open_inbox_note, desc = "Open Inbox" },
    { "<leader>na", my_obsidian.action.append_to_inbox_note, desc = "Append To Inbox" },
    { "<leader>n/", my_obsidian.action.search_notes, desc = "Search Notes" },
    { "<leader>nf", my_obsidian.action.quick_switch, desc = "Open Note" },
    { "<leader>nn", my_obsidian.action.new_note, desc = "New Note" },
    { "<leader>nt", my_obsidian.action.todays_note, desc = "Open Today's Note" },
  },
}
