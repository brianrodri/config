---@module "lazy"
---@type obsidian.workspace.WorkspaceSpec[]
local workspaces = {
  {
    name = "Vault",
    path = "~/Documents/Vault",
    ---@diagnostic disable: missing-fields
    overrides = {
      attachments = { img_folder = "8 - Meta/Attachments" },
      daily_notes = { folder = "1 - Journal/Daily" },
      notes_subdir = "2 - Fleeting Notes",
      note_frontmatter_func = nil,
      new_notes_location = "notes_subdir",
      note_id_func = function(title) return title and title:gsub("['\\.]", "") end,
      use_advanced_uri = true,
    },
  },
}

---@module "lazy"
---@type LazySpec
return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  dependencies = { "nvim-lua/plenary.nvim" },
  ---@module "obsidian"
  ---@type obsidian.config.ClientOpts
  opts = { workspaces = workspaces, ui = { enable = false } },
}
