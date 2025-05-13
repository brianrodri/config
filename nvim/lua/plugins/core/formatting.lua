local toggle = require("my.toggle")

local FORMAT_OPTS = { lsp_format = "fallback" }

---@module "lazy"
---@type LazySpec
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = { format_on_save = function() return toggle.get_var("autoformat") and FORMAT_OPTS or nil end },
  keys = {
    { "<leader>cq", function() require("conform").format(FORMAT_OPTS) end, desc = "Format" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        toggle_buffer_autoformat():map("<leader>oq")
        toggle_global_autoformat():map("<leader>oQ")
      end,
    })
  end,
}
