---@module "lazy"
---@type LazySpec
return {
  {
    "frankroeder/parrot.nvim",
    dependencies = { "ibhagwan/fzf-lua" },
    opts = {
      providers = {
        anthropic = {
          api_key = os.getenv("ANTHROPIC_API_KEY"),
        },
      },
    },
  },

  {
    "saghen/blink.cmp",
    ---@module "blink-cmp"
    ---@type blink.cmp.Config
    opts = {
      sources = {
        default = { "parrot" },
        providers = {
          parrot = {
            module = "parrot.completion.blink",
            name = "parrot",
            opts = { show_hidden_files = false, max_items = 5 },
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
