---@module "lazy"
---@type LazySpec
return {
  "akinsho/bufferline.nvim",
  ---@module "bufferline"
  ---@type bufferline.UserConfig
  opts = {
    options = {
      style_preset = 2,
      close_command = function(buf) require("snacks.bufdelete").delete({ buf = buf }) end,
      right_mouse_command = function(buf) require("snacks.bufdelete").delete({ buf = buf }) end,
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
    },
  },
  keys = {
    { "<leader>bR", "<cmd>BufferLineCloseRight<cr>", desc = "Delete Buffers to the Right" },
    { "<leader>bL", "<cmd>BufferLineCloseLeft<cr>", desc = "Delete Buffers to the Left" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Left" },
    { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer Right" },
  },
}
