---@module "lazy"
---@type LazySpec
return {
  "echasnovski/mini.nvim",
  main = "mini.files",
  opts = {
    windows = {
      preview = true,
      width_focus = 32,
      width_nofocus = 16,
      width_preview = 64,
    },
    mappings = {
      go_in = "",
      go_in_plus = "L",
      go_out = "",
      go_out_plus = "H",
      reset = "<c-c>",
      reveal_cwd = "g.",
      synchronize = "<cr>",
      trim_left = "<c-h>",
      trim_right = "<c-l>",
    },
  },
  keys = {
    {
      "-",
      function()
        local buf_file = vim.api.nvim_buf_get_name(0)
        require("mini.files").open(vim.uv.fs_stat(buf_file) and buf_file or nil)
      end,
      { desc = "Open Directory" },
    },
  },
}
