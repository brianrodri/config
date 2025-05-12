---@module "conform"
---@type conform.FormatOpts
local FORMAT_OPTS = { timeout_ms = 500, lsp_format = "fallback" }

---@return boolean
local function is_global_autoformat_enabled() return vim.g.autoformat == nil or vim.g.autoformat end

---@param state boolean
local function set_global_autoformat(state)
  vim.g.autoformat = state
  vim.b.autoformat = nil
end

---@param bufnr? integer
---@return boolean
local function is_buffer_autoformat_enabled(bufnr)
  if bufnr == nil or bufnr == 0 then bufnr = vim.api.nvim_get_current_buf() end
  return vim.b[bufnr].autoformat == nil and is_global_autoformat_enabled() or vim.b[bufnr].autoformat
end

---@param state boolean
---@param bufnr? integer
local function set_buffer_autoformat(state, bufnr)
  if bufnr == nil or bufnr == 0 then bufnr = vim.api.nvim_get_current_buf() end
  vim.b[bufnr].autoformat = state
end

---@module "snacks"
---@param bufnr? integer
---@return snacks.toggle.Class
local function toggle_buffer_autoformat(bufnr)
  return require("snacks").toggle({
    name = "Auto Format (local)",
    get = function() return is_buffer_autoformat_enabled(bufnr) end,
    set = function(state) set_buffer_autoformat(state, bufnr) end,
  })
end

---@module "snacks"
---@return snacks.toggle.Class
local function toggle_global_autoformat()
  return require("snacks").toggle({
    name = "Auto Format (global)",
    get = function() return is_global_autoformat_enabled() end,
    set = function(state) set_global_autoformat(state) end,
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
    format_on_save = function(bufnr) return is_buffer_autoformat_enabled(bufnr) and FORMAT_OPTS or nil end,
  },
  keys = {
    { "<leader>cq", function() require("conform").format(FORMAT_OPTS) end, desc = "Format Buffer" },
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
