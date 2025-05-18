local Vaults = require("my.vaults")

local function with_cli(path, runner)
  if not runner then
    runner, path = path, runner
  end
  return function()
    local cli = require("obsidian").get_client()
    runner(cli, path and cli:resolve_note(path.path))
  end
end

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
      {
        "<leader>na",
        with_cli(Vaults.inbox_path, function(cli, inbox)
          require("snacks").input({ prompt = "Append To Inbox", default = "- " }, function(line)
            if vim.fn.empty(line) == 1 then return end
            cli:write_note(inbox, { update_content = function(lines) return vim.list_extend(lines, { line }) end })
            if not cli:current_note() then return end
            if cli:current_note().path == inbox.path then vim.schedule(function() vim.cmd("bufdo e") end) end
          end)
        end),
        desc = "Append To Inbox",
      },

      { "<leader>no", with_cli(Vaults.inbox_path, function(cli, inbox) cli:open_note(inbox) end), desc = "Open Inbox" },
      { "<leader>n/", with_cli(function(cli) cli:command("search", { args = "" }) end), desc = "Grep Notes" },
      { "<leader>ns", with_cli(function(cli) cli:command("quick_switch", { args = "" }) end), desc = "Search Note" },
      { "<leader>sn", with_cli(function(cli) cli:command("quick_switch", { args = "" }) end), desc = "Search Note" },
      { "<leader>nn", with_cli(function(cli) cli:command("new", { args = "" }) end), desc = "New Note" },
      { "<leader>nt", with_cli(function(cli) cli:command("today", { args = "" }) end), desc = "Open Today's Note" },
    },
  },

  -- {
  --   "zbirenbaum/copilot.lua",
  --   ---@module "copilot"
  --   ---@type CopilotConfig
  --   opts = { workspace_folders = { my_vaults.personal:inbox_path() } },
  --   opts_extend = { "workspace_folders" },
  -- },

  {
    "brianrodri/projects.nvim",
    ---@module "projects"
    ---@type v1.ProjectOptions
    opts = { patterns = { ".obsidian" } },
    opts_extend = { "patterns" },
  },
}
