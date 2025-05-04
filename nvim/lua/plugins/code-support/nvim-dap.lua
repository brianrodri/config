---@module "lazy"
---@type LazySpec
return {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
    init = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local keymaps = require("config.keymaps")
        keymaps.set_dap_keymaps()
        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close
    end,
}
