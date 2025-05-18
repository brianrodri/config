local MODULE_NAMES = {
  "godot",
  "json",
  "lua",
  "markdown",
  "rust",
  "toml",
  "typescript",
  "vimdoc",
  "yaml",
}

return vim.iter(MODULE_NAMES):map(function(name) require("plugins.lang." .. name) end):totable()
