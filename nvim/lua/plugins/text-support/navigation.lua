--- @module "lazy"
--- @type LazySpec
return {

    { -- Key mappings for "surrounding" text objects with characters
        "echasnovski/mini.nvim",
        config = function()
            require("mini.surround").setup({
                mappings = {
                    add = "ys",
                    delete = "ds",
                    find = "",
                    find_left = "",
                    highlight = "",
                    replace = "cs",
                    update_n_lines = "",
                },
                search_method = "cover_or_next",
            })
        end,
    },

    { -- Highlight, edit, and navigate code by its syntax
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
    },

    { -- Treesitter + textobjects
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}
