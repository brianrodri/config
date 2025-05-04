---@module "lazy"
---@type LazySpec
return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = require("config.keymaps").set_trouble_keymaps,
}
