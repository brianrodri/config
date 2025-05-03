--- @module "lazy"
--- @type LazySpec
return { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
        },
        attach_to_untracked = true,
        on_attach = require("config.keymaps").set_git_keymaps,
    },
}
