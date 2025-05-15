local my_vaults = require("my.vaults")

---@module "lazy"
---@type LazySpec
return {
  {
    "brianrodri/obsidian.nvim",
    branch = "substitution-context",
    dependencies = { "nvim-lua/plenary.nvim" },
    ---@module "obsidian"
    ---@type obsidian.config.ClientOpts
    ---@diagnostic disable: missing-fields
    opts = {
      workspaces = { my_vaults.personal },
      ui = { enable = false },
    },
    keys = {
      { "<leader>no", my_vaults.action.open_inbox_note, desc = "Open Inbox" },
      { "<leader>na", my_vaults.action.append_to_inbox_note, desc = "Append To Inbox" },
      { "<leader>n/", my_vaults.action.search_notes, desc = "Grep Notes" },
      { "<leader>ns", my_vaults.action.quick_switch, desc = "Search Note" },
      { "<leader>nn", my_vaults.action.new_note, desc = "New Note" },
      { "<leader>nt", my_vaults.action.todays_note, desc = "Open Today's Note" },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    ---@module "copilot"
    ---@type CopilotConfig
    opts = { workspace_folders = { my_vaults.personal:inbox_path() } },
    opts_extend = { "workspace_folders" },
  },

  {
    "brianrodri/project.nvim",
    ---@module "project_nvim"
    ---@type ProjectOptions
    opts = { patterns = { ".obsidian" } },
    opts_extend = { "patterns" },
  },
}
