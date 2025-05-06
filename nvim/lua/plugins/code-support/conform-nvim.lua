local function is_buffer_autoformat_enabled()
  if vim.b.autoformat ~= nil then return vim.b.autoformat end
  if vim.g.autoformat ~= nil then return vim.g.autoformat end
  return true
end

local function toggle_buffer_autoformat()
  local snacks = require("snacks")
  return snacks.toggle({
    name = "Auto Format (buffer)",
    get = is_buffer_autoformat_enabled,
    set = function(val) vim.b.autoformat = val end,
  })
end

local function toggle_global_autoformat()
  local snacks = require("snacks")
  return snacks.toggle({
    name = "Auto Format (global)",
    get = function()
      if vim.g.autoformat ~= nil then return vim.g.autoformat end
      return true
    end,
    set = function(val)
      vim.g.autoformat = val
      vim.b.autoformat = nil
    end,
  })
end

---@module "lazy"
---@type LazySpec
return { -- Autoformatting
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    format_on_save = function()
      if is_buffer_autoformat_enabled() then
        return { timeout_ms = 500, lsp_format = "fallback" }
      else
        return nil
      end
    end,
  },
  keys = {
    {
      "<leader>cq",
      function() require("conform").format({ lsp_format = "fallback" }) end,
      desc = "Format Buffer",
    },
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
