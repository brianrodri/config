---@module "lazy"
---@type LazySpec
return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = {
    { "<leader>xx", function() require("trouble").toggle("diagnostics") end, desc = "Diagnostics" },
    { "<leader>xt", function() require("trouble").toggle("todo") end, desc = "Todo" },
    { "<leader>xq", function() require("trouble").toggle("qflist") end, desc = "Quick Fix List" },
    { "<leader>xl", function() require("trouble").toggle("loclist") end, desc = "Location List" },
  },
}
