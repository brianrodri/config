local function get_gitsigns_diff()
  local gitsigns = vim.b.gitsigns_status_dict
  return gitsigns and { added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed }
end

local function parrot_status()
  local status_info = require("parrot.config").get_status_info()
  local status = ""
  if status_info.is_chat then
    status = status_info.prov.chat.name
  else
    status = status_info.prov.command.name
  end
  return string.format("%s(%s)", status, status_info.model)
end

---@module "lazy"
---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "lewis6991/gitsigns.nvim",
    "folke/noice.nvim",
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
        lualine_x = { parrot_status, "filetype" },
        lualine_y = { "location" },
        lualine_z = { "lsp_status" },
      },
    }
  end,
}
