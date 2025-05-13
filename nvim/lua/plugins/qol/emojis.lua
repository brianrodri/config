---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "xiyaowong/telescope-emoji.nvim" },
    opts = { extensions = { emoji = {} } },
    -- stylua: ignore
    -- luacheck: no max line length
    keys = {
      { "<leader>se", function() require("telescope").extensions.emoji.emoji() end, desc = "Find Emojis" },
    },
  },

  {
    "saghen/blink.cmp",
    dependencies = { "moyiz/blink-emoji.nvim" },
    opts = {
      sources = {
        default = { "emoji" },
        providers = {
          emoji = { module = "blink-emoji", name = "Emoji", score_offset = 20 },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
