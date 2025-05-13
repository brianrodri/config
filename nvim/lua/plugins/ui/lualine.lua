local function get_gitsigns_diff()
  local gitsigns = vim.b.gitsigns_status_dict
  return gitsigns and { added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed }
end

---@module "lazy"
---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
    "folke/noice.nvim",
    "AndreM222/copilot-lualine",
  },
  opts = function()
    return {
      theme = "everforest",
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "b:gitsigns_head", { "diff", source = get_gitsigns_diff }, "diagnostics" },
        lualine_c = {
          "filename",
          {
            function() return require("noice").api.status.search.get() end,
            cond = function() return require("noice").api.status.search.has() end,
          },
        },
        lualine_x = { "copilot", "filetype" },
        lualine_y = {
          { function() return string.format(" %2d", vim.fn.line(".")) end },
          { function() return string.format(" %2d", vim.fn.charcol(".")) end },
        },
        lualine_z = { { "lsp_status", ignore_lsp = { "copilot" } } },
      },
    }
  end,
}
