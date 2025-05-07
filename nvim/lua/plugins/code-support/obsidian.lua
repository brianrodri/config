local INBOX_NOTE_PATH = "0 - Index/Inbox.md"

---@return obsidian.Client, obsidian.Note
local resolve_inbox_note = function()
  local client = assert(require("obsidian").get_client(), "Obsidian Client not ready")
  local inbox_note = client:resolve_note(INBOX_NOTE_PATH)
  assert(inbox_note and inbox_note:exists(), "Obsidian Note not found: " .. INBOX_NOTE_PATH)
  return client, inbox_note
end

local open_inbox_note = function()
  local client, inbox_note = resolve_inbox_note()
  client:open_note(inbox_note)
end

local append_to_inbox_note = function()
  require("snacks.input").input({ prompt = "Append To " .. INBOX_NOTE_PATH, default = "- " }, function(value)
    local update_content = function(lines) return vim.list_extend(lines, { value }) end
    local client, inbox_note = resolve_inbox_note()
    client:write_note(inbox_note, { update_content = update_content })
    local current_note = client:current_note()
    if current_note and current_note.path == inbox_note.path then client:open_note(current_note) end
  end)
end

local parse_iso_name = function(iso)
  if type(iso) ~= "string" then return nil end
  local iso_date_ok, _, d, m, y = string.find(iso, "^(%d%d%d%d)-(%d%d)-(%d%d)$")
  if iso_date_ok then return { year = y, month = m, day = d } end
  local iso_week_ok, _, wky, wkn = string.find(iso, "^(%d%d%d%d)-W(%d%d)$")
  if iso_date_ok then return {} end
  return nil
end

---@module "lazy"
---@type LazySpec
return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  dependencies = { "nvim-lua/plenary.nvim" },
  ---@module "obsidian"
  ---@type obsidian.config.ClientOpts
  ---@diagnostic disable: missing-fields
  opts = {
    workspaces = {
      {
        name = "Vault",
        path = "~/Documents/Vault",
        overrides = {
          attachments = { img_folder = "8 - Meta/Attachments" },
          daily_notes = { folder = "1 - Journal/Daily" },
          disable_frontmatter = true,
          notes_subdir = "2 - Fleeting Notes",
          new_notes_location = "notes_subdir",
          note_id_func = function(title) return title and title:gsub("['\\.]", "") end,
          templates = {
            folder = "8 - Meta/Neovim Templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
            substitutions = {
              -- TODO: Implement with: https://github.com/obsidian-nvim/obsidian.nvim/issues/137
              curr_iso_date = function() return "TODO" end,
              next_iso_date = function() return "TODO" end,
              prev_iso_date = function() return "TODO" end,
              curr_iso_week = function() return "TODO" end,
              next_iso_week = function() return "TODO" end,
              prev_iso_week = function() return "TODO" end,
            },
          },
          use_advanced_uri = true,
        },
      },
    },
    ui = { enable = false },
  },
  keys = {
    { "<leader>jf", "<cmd>ObsidianSearch<cr>", desc = "Find Note" },
    { "<leader>jn", "<cmd>ObsidianNew<CR>", desc = "New Note" },
    { "<leader>jt", "<cmd>ObsidianToday<cr>", desc = "Open Today's Note" },
    { "<leader>jo", open_inbox_note, desc = "Open Inbox" },
    { "<leader>ja", append_to_inbox_note, desc = "Append To Inbox" },
  },
}
