local my_os = require("my.os")

-- `:h yanky.txt | /windows wsl`
local windows_wsl_wrapper = function() require("yanky.wrappers").remove_carriage_return(next) end

---@module "lazy"
---@type LazySpec
return {
  {
    "gbprod/yanky.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      ring = { permanent_wrapper = my_os.name == "wsl" and windows_wsl_wrapper or nil },
      system_clipboard = { sync_with_ring = false },
    },
    keys = {
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" } },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" } },
      { "iy", function() require("yanky.textobj").lasy_put() end, { "o", "x" }, desc = "Last Put" },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "gbprod/yanky.nvim" },
    opts = { extensions = { yank_history = {} } },
  },
}
