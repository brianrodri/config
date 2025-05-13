---@module "lazy"
---@type LazySpec
return {
  { -- Key remaps for seamlessly moving between tmux panes adjacent to a NeoVim pane.
    "aserowy/tmux.nvim",
    event = "BufReadPre",
    opts = { enable_default_keybindings = true },
  },

  {
    "saghen/blink.cmp",
    dependencies = { "mgalliou/blink-cmp-tmux" },
    opts = {
      sources = {
        default = { "tmux" },
        providers = {
          tmux = {
            module = "blink-cmp-tmux",
            name = "tmux",
            opts = { all_panes = true, capture_history = true },
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
