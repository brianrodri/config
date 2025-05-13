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
    dependencies = { "moyiz/blink-emoji.nvim", "MahanRahmati/blink-nerdfont.nvim" },
    opts = {
      sources = {
        default = { "emoji", "nerdfont" },
        providers = {
          emoji = { module = "blink-emoji", name = "Emoji", score_offset = 20 },
          nerdfont = { module = "blink-nerdfont", name = "Nerd Fonts", score_offset = 10 },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
