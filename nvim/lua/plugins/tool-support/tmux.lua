---@module "lazy"
---@type LazySpec
return { -- Key remaps for seamlessly moving between tmux panes adjacent to a NeoVim pane.
    "aserowy/tmux.nvim",
    event = "BufReadPre",
    opts = { enable_default_keybindings = true },
}
