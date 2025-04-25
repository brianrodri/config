return {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.everforest_background = "hard"
        vim.g.everforest_enable_italic = true
        vim.g.everforest_better_performance = 1
        -- vim.g.everforest_float_style = "dim"
        vim.cmd.colorscheme("everforest")
    end,
}
