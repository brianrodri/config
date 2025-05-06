---@module "lazy"
---@type LazySpec
return {
  "tpope/vim-fugitive",
  keys = {
    { "<leader>gc", "<cmd>Git commit<cr>", desc = "Commit" },
    { "<leader>gp", "<cmd>Git push<cr>", desc = "Push" },
    { "<leader>gl", "<cmd>Git pull<cr>", desc = "Pull" },
    { "<leader>gs", "<cmd>Git<cr>", desc = "Pull" },
  },
}
