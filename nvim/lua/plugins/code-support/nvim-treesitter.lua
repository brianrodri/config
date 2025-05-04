---@module "lazy"
---@type LazySpec
return {
    "nvim-treesitter/nvim-treesitter",
    ---@module "nvim-treesitter"
    ---@type TSConfig
    ---@diagnostic disable: missing-fields
    opts = {
        ensure_installed = { "vimdoc" },
        highlight = { enable = true },
        build = ":TSUpdate",
        main = "nvim-treesitter.configs",
    },
    opts_extend = { "ensure_installed" },
}
