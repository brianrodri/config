---@module "lazy"
---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<Esc>"] = function(...) require("telescope.actions").close(...) end,
          ["<C-u>"] = false,
        },
      },
    },
  },
}
