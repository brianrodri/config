local keymaps = require("config.keymaps")

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- Creates a beautiful debugger UI
        "rcarriga/nvim-dap-ui",
        -- Required dependency for nvim-dap-ui
        "nvim-neotest/nvim-nio",
        -- Installs the debug adapters for you
        "williamboman/mason.nvim",
        { "jay-babu/mason-nvim-dap.nvim", opts = { automatic_installation = true, ensure_installed = {} } },

        -- Debuggers
        "leoluz/nvim-dap-go",
    },
    init = function()
        keymaps.set_dap_keymaps()
        local dap = require("dap")
        local dapui = require("dapui")
        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close
    end,
}
