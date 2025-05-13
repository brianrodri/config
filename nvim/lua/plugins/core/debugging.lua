---@module "lazy"
---@type LazySpec
return {
  "mfussenegger/nvim-dap",
  dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
  init = function()
    local dap = require("dap")
    local dapui = require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
  end,
  -- stylua: ignore
  -- luacheck: no max line length
  keys = {
    { "<leader>dn", function() require("dap").continue() end, desc = "Start/Resume" },
    { "<leader>d.", function() require("dap").run_last() end, desc = "Restart" },
    { "<leader>dl", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dj", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dk", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle UI" },
    { "<leader>dK", function() require("dap.ui.widgets").hover() end, desc = "Show Hover", mode = { "n", "v" } },
    { "<leader>dp", function() require("dap.ui.widgets").preview() end, desc = "Show Preview", mode = { "n", "v" } },
    { "<leader>df", function() local widgets = require("dap.ui.widgets") widgets.centered_float(widgets.frames) end, desc = "Show Frames" },
    { "<leader>ds", function() local widgets = require("dap.ui.widgets") widgets.centered_float(widgets.scopes) end, desc = "Show Scopes" },
  },
}
