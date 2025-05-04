---@module "lazy"
---@type LazySpec
return {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    ---@module "nvim-treesitter"
    ---@type TSConfig
    ---@diagnostic disable: missing-fields
    opts = {
        highlight = { enable = true },
    },
}
