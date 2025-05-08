local my_utils = require("my-utils")

local ONE_DAY_IN_SECS = 86400

-- TODO: Find a way to include this in template definitions.
local FOLDER_FORMATS = {
  ["Daily Template"] = "%Y-%m-%d",
  ["Weekly Template"] = "%Y-W%V",
  ["Monthly Template"] = "%Y-%m",
  ["Yearly Template"] = "%Y",
}

---@param target obsidian.Path
---@param template obsidian.Path
local try_parse = function(target, template)
  return my_utils.try_parse(FOLDER_FORMATS[template.stem], target.stem)
end

---@module "obsidian"
---@type { [string]: fun(target: obsidian.Path, template: obsidian.Path): string }
local SUBSTITUTIONS = {
  pretty_date = function(target, template)
    local epoch = assert(try_parse(target, template))
    return my_utils.pretty_date(epoch)
  end,
  pretty_week = function(target, template)
    local epoch = assert(try_parse(target, template))
    return my_utils.pretty_week(epoch)
  end,
  curr_iso_date = function(target, template)
    local epoch = assert(try_parse(target, template))
    return my_utils.iso_date(epoch)
  end,
  prev_iso_date = function(target, template)
    local epoch = assert(try_parse(target, template))
    return my_utils.iso_date(epoch - ONE_DAY_IN_SECS)
  end,
  next_iso_date = function(target, template)
    local epoch = assert(try_parse(target, template))
    return my_utils.iso_date(epoch + ONE_DAY_IN_SECS)
  end,
  curr_iso_week = function(target, template)
    local epoch = assert(try_parse(target, template))
    return my_utils.iso_week(epoch)
  end,
  curr_iso_week_number = function(target, template)
    local epoch = assert(try_parse(target, template))
    return tostring(my_utils.iso_week_number(epoch))
  end,
  prev_iso_week = function(target, template)
    local epoch = assert(try_parse(target, template))
    return my_utils.iso_week(epoch - 7 * ONE_DAY_IN_SECS)
  end,
  next_iso_week = function(target, template)
    local epoch = assert(try_parse(target, template))
    return my_utils.iso_week(epoch + 7 * ONE_DAY_IN_SECS)
  end,
}

local resolve_inbox_note = function()
  local inbox_note_path = "0 - Index/Inbox.md"
  local client = assert(require("obsidian").get_client(), "Obsidian Client not ready")
  local inbox_note = client:resolve_note(inbox_note_path)
  assert(inbox_note and inbox_note:exists(), "Obsidian Note not found: " .. inbox_note_path)
  return client, inbox_note
end

local open_inbox_note = function()
  local client, inbox_note = resolve_inbox_note()
  client:open_note(inbox_note)
end

local append_to_inbox_note = function()
  require("snacks.input").input({ prompt = "Append To Inbox", default = "- " }, function(value)
    local client, inbox_note = resolve_inbox_note()
    client:write_note(inbox_note, { update_content = my_utils.bind_right(vim.list_extend, { value }) })
    local current_note = client:current_note()
    if current_note and current_note.path == inbox_note.path then client:open_note(current_note) end
  end)
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
          notes_subdir = "/",
          disable_frontmatter = true,
          note_path_func = function(spec)
            if my_utils.try_parse("%Y-%m-%d", spec.id) then
              return string.format("1 - Journal/Daily/%s.md", spec.id)
            elseif my_utils.try_parse("%Y-W%V", spec.id) then
              return string.format("1 - Journal/Weekly/%s.md", spec.id)
            else
              return string.format("2 - Fleeting Notes/%s.md", spec.id)
            end
          end,
          note_id_func = function(title) return title end,
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
    { "<leader>j/", "<cmd>ObsidianSearch<cr>", desc = "Search Notes" },
    { "<leader>jf", "<cmd>ObsidianQuickSwitch<cr>", desc = "Open Note" },
    { "<leader>jn", "<cmd>ObsidianNew<cr>", desc = "New Note" },
    { "<leader>jt", "<cmd>ObsidianToday<cr>", desc = "Open Today's Note" },
    { "<leader>jo", open_inbox_note, desc = "Open Inbox" },
    { "<leader>ja", append_to_inbox_note, desc = "Append To Inbox" },
  },
}
