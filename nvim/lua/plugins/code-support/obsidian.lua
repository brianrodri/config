local my_utils = require("my-utils")

local INBOX_NOTE_PATH = "0 - Index/Inbox.md"

local ONE_DAY_IN_SECS = 86400
local ONE_WEEK_IN_SECS = ONE_DAY_IN_SECS * 7

---@module "obsidian"
---@type { [string]: fun(note: obsidian.Note): string }
local SUBSTITUTIONS = {
  pretty_date = function(note)
    local epoch = assert(my_utils.try_parse_iso(note.path.stem))
    return my_utils.pretty_date(epoch)
  end,
  pretty_week = function(note)
    local epoch = assert(my_utils.try_parse_iso(note.path.stem))
    return my_utils.pretty_week(epoch)
  end,
  curr_iso_date = function(note)
    local epoch = assert(my_utils.try_parse_iso(note.path.stem))
    return my_utils.iso_date(epoch)
  end,
  prev_iso_date = function(note)
    local epoch = assert(my_utils.try_parse_iso(note.path.stem))
    return my_utils.iso_date(epoch - ONE_DAY_IN_SECS)
  end,
  next_iso_date = function(note)
    local epoch = assert(my_utils.try_parse_iso(note.path.stem))
    return my_utils.iso_date(epoch + ONE_DAY_IN_SECS)
  end,
  curr_iso_week = function(note)
    local epoch = assert(my_utils.try_parse_iso(note.path.stem))
    return my_utils.iso_week(epoch)
  end,
  curr_iso_week_number = function(note)
    local epoch = assert(my_utils.try_parse_iso(note.path.stem))
    return tostring(my_utils.iso_week_number(epoch))
  end,
  prev_iso_week = function(note)
    local epoch = assert(my_utils.try_parse_iso(note.path.stem))
    return my_utils.iso_week(epoch - ONE_WEEK_IN_SECS)
  end,
  next_iso_week = function(note)
    local epoch = assert(my_utils.try_parse_iso(note.path.stem))
    return my_utils.iso_week(epoch + ONE_WEEK_IN_SECS)
  end,
}

local resolve_note = function()
  ---@type obsidian.Client
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
  "brianrodri/obsidian.nvim",
  branch = "subst-args",
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
            substitutions = SUBSTITUTIONS,
          },
          use_advanced_uri = true,
        },
      },
    },
    ui = { enable = false },
  },
  keys = {
    { "<leader>jf", "<cmd>ObsidianSearch<cr>", desc = "Find Note" },
    { "<leader>jn", "<cmd>ObsidianNew<CR>",    desc = "New Note" },
    { "<leader>jt", "<cmd>ObsidianToday<cr>",  desc = "Open Today's Note" },
    { "<leader>jo", open_note,                 desc = "Open Inbox" },
    { "<leader>ja", append_to_note,            desc = "Append To Inbox" },
  },
}
