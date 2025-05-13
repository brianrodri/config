local utils = require("my.utils")

local FORMAT_OPTS = { lsp_format = "fallback" }

---@module "lazy"
---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = { format_on_save = function() return utils.get_var("autoformat") and FORMAT_OPTS or nil end },
  keys = {
    { "<leader>cq", function() require("conform").format(FORMAT_OPTS) end, desc = "Format" },
  },
}
