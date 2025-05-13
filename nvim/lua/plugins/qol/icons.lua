---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "2KAbhishek/nerdy.nvim" },
    opts = { extensions = { nerdy = {} } },
    -- stylua: ignore
    -- luacheck: no max line length
    keys = {
      { "<leader>si", function() require("telescope").extensions.nerdy.nerdy() end, desc = "Find Nerd Font Icons" },
    },
  },

  {
    "saghen/blink.cmp",
    dependencies = { "MahanRahmati/blink-nerdfont.nvim" },
    opts = {
      sources = {
        default = { "nerdfont" },
        providers = {
          nerdfont = { module = "blink-nerdfont", name = "Nerd Fonts", score_offset = 14 },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
