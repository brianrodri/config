local keymaps = require("config.keymaps")

return { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-telescope/telescope-ui-select.nvim",
        "2kabhishek/nerdy.nvim",
    },
    opts = {
        defaults = {
            mappings = {
                i = {
                    ["<Esc>"] = function(...) require("telescope.actions").close(...) end,
                    ["<C-u>"] = false,
                },
            },
        },
    },
    keys = keymaps.get_telescope_mappings,
    init = function()
        local load_extension = require("telescope").load_extension
        pcall(load_extension, "nerdy")
        pcall(load_extension, "fzf")
        pcall(load_extension, "ui-select")
    end,
}
