---@module "lazy"
---@type LazySpec
return {
  "folke/which-key.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  ---@module "which-key"
  ---@class wk.Opts
  opts = {
    spec = {
      -- Groups
      { "<leader>b", group = "buffer", icon = { icon = "󰈔 ", hl = "WhichKeyIconCyan" } },
      { "<leader>c", group = "code", icon = { icon = " ", hl = "WhichKeyIconOrange" } },
      { "<leader>d", group = "debug", icon = { icon = "󰃤 ", hl = "WhichKeyIconRed" } },
      { "<leader>f", group = "file", icon = { icon = "󰈔", hl = "WhichKeyIconCyan" } },
      { "<leader>g", group = "git", icon = { icon = " ", hl = "WhichKeyIconGrey" } },
      { "<leader>l", group = "lazy", icon = { icon = "󰒲 ", hl = "WhichKeyIconCyan" } },
      { "<leader>n", group = "notes", icon = { icon = "󰠮 ", hl = "WhichKeyIconPurple" } },
      { "<leader>o", group = "toggle", icon = { icon = " ", hl = "WhichKeyIconYellow" } },
      { "<leader>p", group = "projects", icon = { icon = " ", hl = "WhichKeyIconYellow" } },
      { "<leader>q", group = "quit", icon = { icon = "󰈆 ", hl = "WhichKeyIconRed" } },
      { "<leader>s", group = "search", icon = { icon = " ", hl = "WhichKeyIconGreen" } },
      { "<leader>t", group = "test", icon = { icon = "󰙨 ", hl = "WhichKeyIconGreen" } },
      { "<leader>x", group = "trouble", icon = { icon = "󱍼 ", hl = "WhichKeyIconRed" } },

      -- Hidden keymaps
      { "<leader><C-h>", ":leftabove vsplit<CR>", hidden = true },
      { "<leader><C-j>", ":rightbelow split<CR>", hidden = true },
      { "<leader><C-k>", ":leftabove split<CR>", hidden = true },
      { "<leader><C-l>", ":rightbelow vsplit<CR>", hidden = true },
    },
    keys = {
      scroll_down = "<c-n>",
      scroll_up = "<c-p>",
    },
  },
}
