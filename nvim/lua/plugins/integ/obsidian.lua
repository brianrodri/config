local Vaults = require("my.vaults")

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
      workspaces = { Vaults.personal },
      ui = { enable = false },
    },
    keys = {
      { "<leader>no", Vaults.action.open_inbox_note, desc = "Open Inbox" },
      { "<leader>na", Vaults.action.append_to_inbox_note, desc = "Append To Inbox" },
      { "<leader>n/", Vaults.action.search_notes, desc = "Grep Notes" },
      { "<leader>ns", Vaults.action.quick_switch, desc = "Search Note" },
      { "<leader>nn", Vaults.action.new_note, desc = "New Note" },
      { "<leader>nt", Vaults.action.todays_note, desc = "Open Today's Note" },
    },
  },

  -- {
  --   "zbirenbaum/copilot.lua",
  --   ---@module "copilot"
  --   ---@type CopilotConfig
  --   opts = { workspace_folders = { my_vaults.personal:inbox_path() } },
  --   opts_extend = { "workspace_folders" },
  -- },

  {
    "brianrodri/projects.nvim",
    ---@module "projects"
    ---@type v1.ProjectOptions
    opts = { patterns = { ".obsidian" } },
    opts_extend = { "patterns" },
  },
}
