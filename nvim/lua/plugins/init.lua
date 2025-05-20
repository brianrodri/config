local MODULE_NAMES = {
  "ai",
  "core",
  "integ",
  "lang",
  "qol",
  "ui",
}

return vim.iter(MODULE_NAMES):map(function(name) return { import = "plugins." .. name } end):totable()
