local Dates = require("my.utils.dates")
local Path = require("my.utils.path")

local VERBOSE = "%a %B %-d %Y"
local TERSE = "%a %B %-d"

local ISO_TIME = "%H:%M"
local ISO_DATE = "%Y-%m-%d"
local ISO_WEEK = "%Y-W%V" -- TODO: Need to use "%G" here rather than "%Y" for correctness.

local VAULT_ROOT = Path.new("~", "Documents", "Vault"):normalize():resolve()
local INBOX = Path.new("0 - Index", "Inbox.md")
local DAILY_DIR = Path.new("1 - Journal", "Daily")
local WEEKLY_DIR = Path.new("1 - Journal", "Weekly")
local FLEETING_NOTES_DIR = Path.new("2 - Fleeting Notes")
local ATTACHMENTS_DIR = Path.new("8 - Meta", "Attachments")
local TEMPLATES_DIR = Path.new("8 - Meta", "Neovim Templates")

local note_date_formatter = function(ctx, fmt, delta_days)
  local epoch = Dates.from_fmt(ctx.template.stem:match("Week") and ISO_WEEK or ISO_DATE, tostring(ctx.target_note.id))
  local delta_secs = (delta_days or 0) * (60 * 60 * 24)
  return Dates.to_fmt(fmt, epoch + delta_secs)
end

return {
  inbox_note = INBOX,

  ---@module "obsidian"
  ---@type obsidian.workspace.WorkspaceSpec
  ---@diagnostic disable: missing-fields
  personal = {
    name = "Vault",
    path = VAULT_ROOT.path,
    strict = true,
    overrides = {
      note_id_func = function(title) return title or Dates.to_fmt(ISO_DATE) end,
      note_path_func = function(spec)
        local filename = string.format("%s.md", spec.id)
        if pcall(Dates.from_fmt, ISO_DATE, spec.id) then return DAILY_DIR:new(filename).path end
        if pcall(Dates.from_fmt, ISO_WEEK, spec.id) then return WEEKLY_DIR:new(filename).path end
        return FLEETING_NOTES_DIR:new(filename).path
      end,
      disable_frontmatter = true,
      use_advanced_uri = true,
      attachments = { img_folder = ATTACHMENTS_DIR.path },
      daily_notes = { folder = DAILY_DIR.path, template = "Daily Template.md", workdays_only = false },
      templates = {
        folder = TEMPLATES_DIR.path,
        date_format = ISO_DATE,
        time_format = ISO_TIME,
        substitutions = {
          pretty_date = function(ctx) return note_date_formatter(ctx, VERBOSE) end,
          week_1st_day = function(ctx) return note_date_formatter(ctx, TERSE) end,
          week_6th_day = function(ctx) return note_date_formatter(ctx, TERSE, 6) end,
          curr_iso_date = function(ctx) return note_date_formatter(ctx, ISO_DATE) end,
          prev_iso_date = function(ctx) return note_date_formatter(ctx, ISO_DATE, -1) end,
          next_iso_date = function(ctx) return note_date_formatter(ctx, ISO_DATE, 1) end,
          curr_iso_week = function(ctx) return note_date_formatter(ctx, ISO_WEEK) end,
          prev_iso_week = function(ctx) return note_date_formatter(ctx, ISO_WEEK, -7) end,
          next_iso_week = function(ctx) return note_date_formatter(ctx, ISO_WEEK, 7) end,
          curr_iso_week_number = function(ctx) return note_date_formatter(ctx, "%-V") end,
        },
      },
    },
  },
}
