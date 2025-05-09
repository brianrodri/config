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

---@param path string
---@return obsidian.Client client, obsidian.Note note
local function lookup_note(path)
  local plugin = assert(require("obsidian"), "obsidian.nvim plugin is nil")
  local client = assert(plugin.get_client(), "obsidian.nvim client is nil")
  local note = client:resolve_note(path)
  assert(note and note:exists(), string.format("error resolving path: %s", path))
  return client, note
end

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

return {
  actions = {
    open_inbox_note = function()
      local client, inbox_note = lookup_note(INBOX_NOTE_PATH)
      client:open_note(inbox_note)
    end,
    append_to_inbox_note = function()
      require("snacks").input({ prompt = "Append To Inbox", default = "- " }, function(line)
        if not line or line == "" then return end
        local client, inbox_note = lookup_note(INBOX_NOTE_PATH)
        client:write_note(inbox_note, { update_content = utils.bind_right(vim.list_extend, { line }) })
        if tostring(client:current_note()) == tostring(inbox_note) then client:open_note(inbox_note) end
      end)
    end,
  },

  ---@module "obsidian"
  ---@type obsidian.workspace.WorkspaceSpec
  personal = {
    path = "~/Documents/Vault",
    name = "Vault",
    ---@diagnostic disable-next-line: missing-fields
    overrides = {
      ---@param title string|?
      note_id_func = function(title)
        if not title or title == "" then return tostring(os.date(ISO_DATE_FORMAT)) end
        return title
      end,

      ---@param spec { id: string, dir: obsidian.Path, title: string|? }
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
