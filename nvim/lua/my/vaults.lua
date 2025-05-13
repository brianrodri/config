local utils = require("my.utils")

local PRETTY_DATE_FORMAT = "%a %B %-d %Y"
local ISO_DATE_FORMAT = "%Y-%m-%d"
local ISO_WEEK_FORMAT = "%Y-W%V" -- TODO: Need to use "%G" here rather than "%Y" for correctness.
local TEMPLATE_MAP = { ["Daily Template"] = ISO_DATE_FORMAT, ["Weekly Template"] = ISO_WEEK_FORMAT }
local FOLDER_MAP = { ["1 - Journal/Daily"] = ISO_DATE_FORMAT, ["1 - Journal/Weekly"] = ISO_WEEK_FORMAT }
local INBOX_PATH = "0 - Index/Inbox.md"

---@type fun(): client: obsidian.Client
local function acquire_client() return assert(require("obsidian").get_client(), "failed to acquire client") end

---@type fun(ctx: obsidian.SubstitutionContext): time: integer
local resolve_subst_time = function(ctx)
  assert(ctx.action == "clone_template")
  assert(ctx.target_note.path, string.format("invalid target: %s", tostring(ctx.target_note.path)))
  assert(ctx.template, string.format("invalid template: %s", tostring(ctx.template)))
  local format = assert(TEMPLATE_MAP[ctx.template.stem], string.format("unknown template: %s", ctx.template))
  return assert(utils.try_parse(format, ctx.target_note.path.stem))
end

---@type fun(date_format: string, delta_days?: integer): fun(time: integer): time_str: string
local function date_formatter(date_format, delta_days)
  local delta_time = (delta_days or 0) * 86400 -- 60s * 60m * 24h
  return function(time) return assert(utils.try_format(date_format, time + delta_time)) end
end

---@type fun(date_format: string, delta_days?: integer, date_sep?: string): fun(time: integer): time_str: string
local function week_formatter(date_format, delta_days, date_sep)
  local format_date = date_formatter(date_format, delta_days)
  return function(time)
    local iso_week = assert(utils.try_format(ISO_WEEK_FORMAT, time))
    local start_of_week = assert(utils.try_parse(ISO_WEEK_FORMAT, iso_week))
    local end_of_week = start_of_week + 6 * 86400 -- 60s * 60m * 24h
    return vim.fn.join({ format_date(start_of_week), format_date(end_of_week) }, date_sep or " - ")
  end
end

---@type fun(name: string, data?: table): fun()
local function calling_command(name, data)
  return function() acquire_client():command(name, data or { args = "" }) end
end

return {
  action = {
    open_inbox_note = function()
      local client = acquire_client()
      local note = assert(client:resolve_note(INBOX_PATH), string.format("resolve note error: %s", INBOX_PATH))
      client:open_note(note)
    end,
    append_to_inbox_note = function()
      local client = acquire_client()
      local note = assert(client:resolve_note(INBOX_PATH), string.format("resolve note error: %s", INBOX_PATH))
      require("snacks").input({ prompt = "Append To " .. note.path.stem, default = "- " }, function(line)
        if not line or line == "" then return end
        client:write_note(note, { update_content = utils.bind_right(vim.list_extend, { line }) })
        local current_note = client:current_note()
        if current_note and tostring(current_note.path) == tostring(note.path) then client:open_note(note) end
      end)
    end,
    search_notes = calling_command("search"),
    quick_switch = calling_command("quick_switch"),
    new_note = calling_command("new"),
    todays_note = calling_command("today"),
  },
  ---@module "obsidian"
  ---@type obsidian.workspace.WorkspaceSpec
  personal = {
    path = "~/Documents/Vault",
    name = "Vault",
    ---@diagnostic disable-next-line: missing-fields
    overrides = {
      note_id_func = function(title) return title or tostring(os.date(ISO_DATE_FORMAT)) end,
      note_path_func = function(spec)
        for folder, format in pairs(FOLDER_MAP) do
          if utils.try_parse(format, spec.id) then return string.format("%s/%s.md", folder, spec.id) end
        end
        return string.format("2 - Fleeting Notes/%s.md", spec.id)
      end,
      disable_frontmatter = true,
      use_advanced_uri = true,
      notes_subdir = "",
      ---@diagnostic disable-next-line: missing-fields
      attachments = {
        img_folder = "8 - Meta/Attachments",
      },
      ---@diagnostic disable-next-line: missing-fields
      daily_notes = {
        folder = "1 - Journal/Daily",
        template = "Daily Template.md",
        workdays_only = false,
      },
      ---@diagnostic disable-next-line: missing-fields
      templates = {
        folder = "8 - Meta/Neovim Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {
          pretty_date = utils.compose(resolve_subst_time, date_formatter(PRETTY_DATE_FORMAT)),
          pretty_week = utils.compose(resolve_subst_time, week_formatter(PRETTY_DATE_FORMAT)),
          curr_iso_date = utils.compose(resolve_subst_time, date_formatter(ISO_DATE_FORMAT)),
          prev_iso_date = utils.compose(resolve_subst_time, date_formatter(ISO_DATE_FORMAT, -1)),
          next_iso_date = utils.compose(resolve_subst_time, date_formatter(ISO_DATE_FORMAT, 1)),
          curr_iso_week = utils.compose(resolve_subst_time, date_formatter(ISO_WEEK_FORMAT)),
          prev_iso_week = utils.compose(resolve_subst_time, date_formatter(ISO_WEEK_FORMAT, -7)),
          next_iso_week = utils.compose(resolve_subst_time, date_formatter(ISO_WEEK_FORMAT, 7)),
          curr_iso_week_number = utils.compose(resolve_subst_time, date_formatter("%-V")),
        },
      },
    },
  },
}
