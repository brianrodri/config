local keymaps = require("config.keymaps")

--- @module "lazy"
--- @type LazySpec
return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = keymaps.set_neotest_keymaps,
}
