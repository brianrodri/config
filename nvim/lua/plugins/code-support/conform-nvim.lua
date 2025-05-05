local keymaps = require("config.keymaps")

local function get_enabled(global)
  if not global and vim.b.autoformat ~= nil then
    return vim.b.autoformat
  elseif vim.g.autoformat ~= nil then
    return vim.g.autoformat
  else
    return true
  end
end

local function set_enabled(enable, global)
  if global then
    vim.g.autoformat = enable
    vim.b.autoformat = nil
  else
    vim.b.autoformat = enable
  end
end

---@module "lazy"
---@type LazySpec
return { -- Autoformatting
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  init = function() return keymaps.set_formatter_keymaps(get_enabled, set_enabled) end,
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    format_on_save = function(buf)
      if get_enabled(buf) then return { timeout_ms = 500, lsp_format = "fallback" } end
      return nil
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      markdown = { "markdownlint" },
      typescript = { "prettier" },
    },
  },
}
