local Vaults = require("my.vaults")

--- Returns a callback function that invokes the provided `runner` by passing values loaded from the obsidian.nvim API.
---
---@alias CliRunner fun(client: obsidian.Client, resolved_note?: obsidian.Note, current_note?: obsidian.Note)
---
---@overload fun(runner: CliRunner): fun()
---@overload fun(note_path: my.Path, runner: CliRunner): fun()
local function with_cli(note_path, runner)
  if not runner then
    runner, note_path = note_path, runner
  end
  return function()
    local client = require("obsidian").get_client()
    runner(client, note_path and client:resolve_note(tostring(note_path)), note_path and client:current_note())
  end
end

local append_prompt_to_inbox_note = with_cli(Vaults.inbox_note, function(cli, inbox_note, current_note)
  require("snacks").input({ prompt = "Append To Inbox", default = "- " }, function(text)
    if vim.fn.empty(text) == 1 then return end
    cli:write_note(inbox_note, { update_content = function(lines) return vim.list_extend(lines, { text }) end })
    if current_note and current_note.path == inbox_note.path then vim.schedule(function() vim.cmd("bufdo e") end) end
  end)
end)

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
      { "<leader>na", append_prompt_to_inbox_note, desc = "Append To Inbox" },
      { "<leader>no", with_cli(Vaults.inbox_note, function(cli, inbox) cli:open_note(inbox) end), desc = "Open Inbox" },
      { "<leader>n/", with_cli(function(cli) cli:command("search", { args = "" }) end), desc = "Grep Notes" },
      { "<leader>ns", with_cli(function(cli) cli:command("quick_switch", { args = "" }) end), desc = "Search Notes" },
      { "<leader>nn", with_cli(function(cli) cli:command("new", { args = "" }) end), desc = "New Note" },
      { "<leader>nt", with_cli(function(cli) cli:command("today", { args = "" }) end), desc = "Open Today's Note" },
    },
  },

  {
    "brianrodri/projects.nvim",
    ---@module "projects"
    ---@type v1.ProjectOptions
    opts = { patterns = { ".obsidian" } },
    opts_extend = { "patterns" },
  },
}
