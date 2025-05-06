local keymaps = require("config.keymaps")

---@module "lazy"
---@type LazySpec
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>t", group = "test", icon = { icon = "󰙨 ", hl = "WhichKeyIconGreen" } },
    {
      "<leader>tt",
      function() require("neotest").run.run(vim.fn.expand("%")) end,
      desc = "Test File",
    },
    {
      "<leader>tT",
      function() require("neotest").run.run(vim.uv.cwd()) end,
      desc = "Test All Files",
    },
    { "<leader>t*", function() require("neotest").run.run() end, desc = "Test Nearest" },
    {
      "<leader>td",
      function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap", suite = true }) end,
      desc = "Test File With DAP",
    },
    { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Test Recent" },
    { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
    {
      "<leader>to",
      function() require("neotest").output.open({ enter = true, auto_close = true }) end,
      desc = "Show Output",
    },
    {
      "<leader>tO",
      function() require("neotest").output_panel.toggle() end,
      desc = "Toggle Output Panel",
    },
    { "<leader>tq", function() require("neotest").run.stop() end, desc = "Stop" },
    {
      "<leader>tw",
      function() require("neotest").watch.toggle(vim.fn.expand("%")) end,
      desc = "Toggle Watch",
    },
  },
}
