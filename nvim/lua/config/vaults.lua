local utils = require("my-utils")

local ONE_DAY = 86400 -- 60s * 60m * 24h

local ISO_DATE_FORMAT = "%Y-%m-%d"
local ISO_WEEK_FORMAT = "%Y-W%V"
local PRETTY_DATE_FORMAT = "%a %B %-d %Y"

local INBOX_NOTE_PATH = "0 - Index/Inbox.md"

local TEMPLATE_FILENAME_FORMAT = {
  ["Daily Template"] = "%Y-%m-%d",
  ["Weekly Template"] = "%Y-W%V",
  ["Monthly Template"] = "%Y-%m",
  ["Yearly Template"] = "%Y",
}

---@param path string
---@return obsidian.Client, obsidian.Note
---@private
local function connect_with_note(path)
  local obsidian = assert(require("obsidian"))
  local client = assert(obsidian.get_client())
  local note = assert(client:resolve_note(path))
  assert(note:exists(), "Obsidian Note could not be found: " .. path)
  return client, note
end

---@param target obsidian.Path
---@param template obsidian.Path
---@return integer
---@private
local resolve_date = function(target, template)
  return assert(utils.try_parse(TEMPLATE_FILENAME_FORMAT[template.stem], target.stem))
end

---@param date_format string
---@param delta_days? integer
---@return fun(time: integer): string
---@private
local function date_formatter(date_format, delta_days)
  local delta_time = (delta_days or 0) * ONE_DAY
  return function(time) return assert(utils.try_format(date_format, time + delta_time)) end
end

---@param date_format string
---@param date_sep? string
---@param delta_days? integer
---@return fun(time: integer): string
---@private
local function week_formatter(date_format, date_sep, delta_days)
  local format_date = date_formatter(date_format, delta_days)
  return function(time)
    local iso_week = assert(utils.try_format(ISO_WEEK_FORMAT, time))
    local start_of_week = assert(utils.try_parse(ISO_WEEK_FORMAT, iso_week))
    return string.format(
      "%s%s%s",
      format_date(start_of_week),
      date_sep or " - ",
      format_date(start_of_week + 6 * ONE_DAY)
    )
  end
end

return {
  actions = {
    open_inbox_note = function()
      local client, inbox_note = connect_with_note(INBOX_NOTE_PATH)
      client:open_note(inbox_note)
    end,
    append_to_inbox_note = function()
      require("snacks").input({ prompt = "Append To Inbox", default = "- " }, function(line)
        local client, inbox_note = connect_with_note(INBOX_NOTE_PATH)
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
      notes_subdir = "/",
      note_path_func = function(spec)
        if utils.try_parse("%Y-%m-%d", spec.id) then
          return string.format("1 - Journal/Daily/%s.md", spec.id)
        elseif utils.try_parse("%Y-W%V", spec.id) then
          return string.format("1 - Journal/Weekly/%s.md", spec.id)
        else
          return string.format("2 - Fleeting Notes/%s.md", spec.id)
        end
      end,
      note_id_func = utils.identity,
      disable_frontmatter = true,
      use_advanced_uri = true,

      ---@diagnostic disable-next-line: missing-fields
      attachments = { img_folder = "8 - Meta/Attachments" },
      ---@diagnostic disable-next-line: missing-fields
      daily_notes = { folder = "1 - Journal/Daily" },
      ---@diagnostic disable-next-line: missing-fields
      templates = {
        folder = "8 - Meta/Neovim Templates",
        substitutions = {
          pretty_date = utils.compose(resolve_date, date_formatter(PRETTY_DATE_FORMAT)),
          pretty_week = utils.compose(resolve_date, week_formatter(PRETTY_DATE_FORMAT)),
          curr_iso_date = utils.compose(resolve_date, date_formatter(ISO_DATE_FORMAT)),
          prev_iso_date = utils.compose(resolve_date, date_formatter(ISO_DATE_FORMAT, -1)),
          next_iso_date = utils.compose(resolve_date, date_formatter(ISO_DATE_FORMAT, 1)),
          curr_iso_week = utils.compose(resolve_date, date_formatter(ISO_WEEK_FORMAT)),
          prev_iso_week = utils.compose(resolve_date, date_formatter(ISO_WEEK_FORMAT, -7)),
          next_iso_week = utils.compose(resolve_date, date_formatter(ISO_WEEK_FORMAT, 7)),
          curr_iso_week_number = utils.compose(resolve_date, date_formatter("%-V")),
        },
      },
    },
  },
}
