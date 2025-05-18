local Funcs = require("my.utils.funcs")

---@module "lazy"
---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = function() return Funcs.get_var("autoformat") and {} or nil end,
  },
  keys = {
    { "<leader>cq", function() require("conform").format() end, desc = "Format" },
  },
}
