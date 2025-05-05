local function get_gitsigns_diff()
  local gitsigns = vim.b.gitsigns_status_dict
  return gitsigns
    and { added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed }
end

---@module "lazy"
---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    return {
      theme = "everforest",
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "b:gitsigns_head", { "diff", source = get_gitsigns_diff }, "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = { "lsp_status" },
        lualine_z = { "location" },
      },
      extensions = { "neo-tree", "nvim-dap-ui", "trouble" },
    }
  end,
}
