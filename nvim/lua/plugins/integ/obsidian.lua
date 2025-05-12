local obsidian_config = require("config.integ.obsidian")

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
    workspaces = { obsidian_config.personal },
    ui = { enable = false },
  },
  keys = {
    { "<leader>no", obsidian_config.action.open_inbox_note, desc = "Open Inbox" },
    { "<leader>na", obsidian_config.action.append_to_inbox_note, desc = "Append To Inbox" },
    { "<leader>n/", obsidian_config.action.search_notes, desc = "Search Notes" },
    { "<leader>nf", obsidian_config.action.quick_switch, desc = "Open Note" },
    { "<leader>nn", obsidian_config.action.new_note, desc = "New Note" },
    { "<leader>nt", obsidian_config.action.todays_note, desc = "Open Today's Note" },
  },
}
