---@module "lazy"
---@type LazySpec
return {
  "folke/which-key.nvim",
  ---@module "which-key"
  ---@class wk.Opts
  opts = {
    spec = {
      { "<leader>b", group = "buffer", icon = { icon = "󰈔 ", hl = "WhichKeyIconCyan" } },
      { "<leader>c", group = "code", icon = { icon = " ", color = "WhichKeyIconOrange" } },
      { "<leader>d", group = "debug", icon = { icon = "󰃤 ", hl = "WhichKeyIconRed" } },
      { "<leader>f", group = "find", icon = { icon = " ", hl = "WhichKeyIconGreen" } },
      { "<leader>g", group = "git", icon = { icon = " ", hl = "WhichKeyIcon" } },
      { "<leader>j", group = "journal", icon = { icon = "󰠮 ", hl = "WhichKeyIconPurple" } },
      { "<leader>n", group = "neotree", icon = { icon = "󰙅 ", hl = "WhichKeyIcon" } },
      { "<leader>o", group = "toggle", icon = { icon = " ", color = "WhichKeyIconYellow" } },
      { "<leader>t", group = "test", icon = { icon = "󰙨 ", hl = "WhichKeyIconGreen" } },
      { "<leader>x", group = "trouble", icon = { icon = "󱍼 ", hl = "WhichKeyIconRed" } },
    },
    keys = {
      scroll_down = "<c-n>",
      scroll_up = "<c-p>",
    },
  },
}
