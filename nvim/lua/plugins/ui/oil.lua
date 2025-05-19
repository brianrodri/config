---@module "lazy"
---@type LazySpec
return {
  "stevearc/oil.nvim",
  ---@module "oil"
  ---@type oil.SetupOpts
  opts = {
    watch_for_changes = true,
    win_options = {
      signcolumn = "yes",
    },
    lsp_file_methods = { autosave_changes = true },
    float = {
      padding = 5,
      max_width = 120,
      max_height = 40,
      win_options = {},
      preview_split = "above",
    },
    use_default_keymaps = false,
    keymaps = {
      ["g?"] = { "actions.show_help", mode = "n" },
      ["<CR>"] = "actions.select",
      ["<C-l>"] = { "actions.select", opts = { rightbelow = true, vertical = true } },
      ["<C-h>"] = { "actions.select", opts = { leftabove = true, horizontal = true } },
      ["<C-j>"] = { "actions.select", opts = { rightbelow = true, horizontal = true } },
      ["<C-k>"] = { "actions.select", opts = { leftabove = true, vertical = true } },
      ["K"] = "actions.preview",
      ["q"] = { "actions.close", mode = "n" },
      ["<C-r>"] = "actions.refresh",
      ["<bs>"] = { "actions.parent", mode = "n" },
      ["<c-.>"] = { "actions.open_cwd", mode = "n" },
      ["<C-cr>`"] = { "actions.cd", mode = "n" },
      ["gs"] = { "actions.change_sort", mode = "n" },
      ["gx"] = "actions.open_external",
      ["gh"] = { "actions.toggle_hidden", mode = "n" },
      ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
  },
  dependencies = { "echasnovski/mini.icons", opts = {} },
  lazy = false,
  keys = {
    { "-", function() require("oil").toggle_float() end, desc = "Open Folder" },
  },
}
