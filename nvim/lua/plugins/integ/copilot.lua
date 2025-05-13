---@module "lazy"
---@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    ---@module "copilot"
    ---@type CopilotConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = { workspace_folders = { vim.fs.normalize("~/Repositories") } },
    opts_extend = { "workspace_folders" },
  },

  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "giuxtaposition/blink-cmp-copilot" },
    opts = {
      sources = {
        default = { "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
