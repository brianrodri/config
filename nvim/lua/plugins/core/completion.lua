---@module "lazy"
---@type LazySpec
return {
  "saghen/blink.cmp",
  event = "VimEnter",
  version = "1.*",
  ---@module "blink-cmp"
  ---@type blink.cmp.Config
  opts = { sources = { default = { "lsp", "path", "buffer" } } },
  opts_extend = { "sources.default" },
}
