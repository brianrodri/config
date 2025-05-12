local vault = require("config.vault")

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
    workspaces = { vault.personal },
    ui = { enable = false },
  },
  keys = {
    { "<leader>no", vault.action.open_inbox_note, desc = "Open Inbox" },
    { "<leader>na", vault.action.append_to_inbox_note, desc = "Append To Inbox" },
    { "<leader>n/", vault.action.search_notes, desc = "Search Notes" },
    { "<leader>nf", vault.action.quick_switch, desc = "Open Note" },
    { "<leader>nn", vault.action.new_note, desc = "New Note" },
    { "<leader>nt", vault.action.todays_note, desc = "Open Today's Note" },
  },
}
