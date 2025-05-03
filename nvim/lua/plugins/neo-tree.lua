return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim",
    },
    lazy = false, -- neo-tree handles lazy loading on its own.
    keys = require("config.keymaps").set_neo_tree_keymaps,
}
