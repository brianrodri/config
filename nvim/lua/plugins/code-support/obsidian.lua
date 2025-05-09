local vaults = require("config.vaults")

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
    workspaces = { vaults.personal },
    ui = { enable = false },
  },
  keys = {
    { "<leader>jo", vaults.actions.open_inbox_note, desc = "Open Inbox" },
    { "<leader>ja", vaults.actions.append_to_inbox_note, desc = "Append To Inbox" },
    -- TODO: Refactor these mappings into action functions.
    { "<leader>j/", "<cmd>ObsidianSearch<cr>", desc = "Search Notes" },
    { "<leader>jf", "<cmd>ObsidianQuickSwitch<cr>", desc = "Open Note" },
    { "<leader>jn", "<cmd>ObsidianNew<cr>", desc = "New Note" },
    { "<leader>jt", "<cmd>ObsidianToday<cr>", desc = "Open Today's Note" },
  },
}
