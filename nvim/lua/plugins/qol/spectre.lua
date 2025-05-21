---@module "lazy"
---@type LazySpec
return {
  "nvim-pack/nvim-spectre",
  keys = {
    { "<leader>s%", "<cmd>Spectre<cr>", desc = "Search And Replace", mode = "n" },
  },
  opts = { is_block_ui_break = true },
}
