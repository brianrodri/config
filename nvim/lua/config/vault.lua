local utils = require("my-utils")

-- for parsing, see: https://www.man7.org/linux/man-pages/man3/strptime.3.html
-- for formatting, see: https://www.man7.org/linux/man-pages/man3/strftime.3.html
-- TODO: ISO_WEEK_FORMAT needs to be "%G-W%V" for correctness, but strptime doesn't support "%G" on my system.
-- strftime _does_ support "%G" on my system, however.
local ISO_DATE_FORMAT = "%Y-%m-%d"
local ISO_WEEK_FORMAT = "%Y-W%V"
local ISO_MONTH_FORMAT = "%Y-%m"
local ISO_YEAR_FORMAT = "%Y"
local PRETTY_DATE_FORMAT = "%a %B %-d %Y"

local ONE_DAY = 86400 -- 60s * 60m * 24h

local TEMPLATE_FORMATS = {
  ["Daily Template"] = ISO_DATE_FORMAT,
  ["Weekly Template"] = ISO_WEEK_FORMAT,
  ["Monthly Template"] = ISO_MONTH_FORMAT,
  ["Yearly Template"] = ISO_YEAR_FORMAT,
}

local INBOX_NOTE_PATH = "0 - Index/Inbox.md"

---@return obsidian.Client client
local function acquire_client() return assert(require("obsidian").get_client(), "failed to acquire client") end

---@param ctx obsidian.SubstitutionContext
---@return integer time|?
local resolve_subst_time = function(ctx)
  assert(ctx.action == "clone_template")
  assert(ctx.target_note.path, string.format("invalid target: %s", tostring(ctx.target_note.path)))
  assert(ctx.template, string.format("invalid template: %s", tostring(ctx.template)))
  local format = assert(TEMPLATE_FORMATS[ctx.template.stem], string.format("bad template: %s", ctx.template))
  return assert(utils.try_parse(format, ctx.target_note.path.stem))
end

---@param date_format string
---@param delta_days? integer
---@return fun(time: integer): string
local function date_formatter(date_format, delta_days)
  local delta_time = (delta_days or 0) * ONE_DAY
  return function(time) return assert(utils.try_format(date_format, time + delta_time)) end
end

---@param date_format string
---@param delta_days? integer
---@param date_sep? string
---@return fun(time: integer): string
local function week_formatter(date_format, delta_days, date_sep)
  local format_date = date_formatter(date_format, delta_days)
  return function(time)
    local iso_week = assert(utils.try_format(ISO_WEEK_FORMAT, time))
    local start_of_week = assert(utils.try_parse(ISO_WEEK_FORMAT, iso_week))
    local end_of_week = start_of_week + 6 * ONE_DAY
    return vim.fn.join({ format_date(start_of_week), format_date(end_of_week) }, date_sep or " - ")
  end
end

local function opens_note(name)
  return function()
    local client = acquire_client()
    local note = assert(client:resolve_note(name), string.format("failed to resolve note: %s", name))
    client:open_note(note)
  end
end

local function appends_to_note(name)
  return function()
    local client = acquire_client()
    local note = assert(client:resolve_note(name), string.format("failed to resolve note: %s", name))
    vim.notify(tostring(note))
    require("snacks").input({ prompt = "Append To " .. note.path.stem, default = "- " }, function(line)
      if not line or line == "" then return end
      client:write_note(note, { update_content = utils.bind_right(vim.list_extend, { line }) })
      if tostring(client:current_note().path) == tostring(note.path) then client:open_note(note) end
    end)
  end
end

local function calls_command(cmd_name, cmd_data)
  return function() acquire_client():command(cmd_name, cmd_data or { args = "" }) end
end

return {
  action = {
    open_inbox_note = opens_note(INBOX_NOTE_PATH),
    append_to_inbox_note = appends_to_note(INBOX_NOTE_PATH),
    calls_command = calls_command,
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
        if utils.try_parse(ISO_DATE_FORMAT, spec.id) then
          return string.format("1 - Journal/Daily/%s.md", spec.id)
        elseif utils.try_parse(ISO_WEEK_FORMAT, spec.id) then
          return string.format("1 - Journal/Weekly/%s.md", spec.id)
        elseif utils.try_parse(ISO_MONTH_FORMAT, spec.id) then
          return string.format("1 - Journal/Monthly/%s.md", spec.id)
        elseif utils.try_parse(ISO_YEAR_FORMAT, spec.id) then
          return string.format("1 - Journal/Yearly/%s.md", spec.id)
        else
          return string.format("2 - Fleeting Notes/%s.md", spec.id)
        end
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
