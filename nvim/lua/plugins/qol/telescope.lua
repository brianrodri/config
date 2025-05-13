---@module "lazy"
---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "Myzel394/jsonfly.nvim",
    "2KAbhishek/nerdy.nvim",
  },
  -- stylua: ignore
  -- luacheck: no max line length
  keys = {
    { "<leader>s.", function() require("telescope.builtin").resume() end, desc = "Resume Finding" },
    { "<leader>s?", function() require("telescope.builtin").help_tags() end, desc = "Find Help Docs" },
    { "<leader>s*", function() require("telescope.builtin").grep_string() end, desc = "Find Word Under Cursor" },
    { "<leader>s/", function() require("telescope.builtin").live_grep() end, desc = "Grep Lines" },
    { "<leader>s:", function() require("telescope.builtin").commands() end, desc = "Find Commands" },
    { "<leader>so", function() require("telescope").extensions.jsonfly.jsonfly() end, desc = "Search LSP Options", ft = { "json", "xml", "yaml", "toml" }, mode = { "n" } },
    { "<leader>sb", function() require("telescope.builtin").buffers() end, desc = "Find Buffers" },
    { "<leader>sc", function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config Files" },
    { "<leader>sf", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
    { "<leader>sk", function() require("telescope.builtin").keymaps() end, desc = "Find Keymaps" },
    { "<leader>sp", function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("data") .. "/lazy/" }) end, desc = "Find Plugin Files" },
    { "<leader>sr", function() require("telescope.builtin").oldfiles() end, desc = "Find Recent Files" },
    { "<leader>ss", function() require("telescope.builtin").builtin() end, desc = "Find Telescope Builtins" },
    { "<leader>si", function() require("telescope").extensions.nerdy.nerdy() end, desc = "Find Nerd Font Icons" },
    { "<leader>sz", function() require("telescope.builtin").spell_suggest() end, desc = "Find Spelling Suggestions" },
    { "<leader>sg", function() require("telescope.builtin").git_files() end, desc = "Find Git Files" },
    { "<leader>sG", function() require("telescope.builtin").git_status() end, desc = "Find Changed Git Files" },
  },
  ---@module "telescope"
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<Esc>"] = function(...) require("telescope.actions").close(...) end,
          ["<C-u>"] = false,
        },
      },
    },
  },
  init = function()
    require("telescope").load_extension("nerdy")
    require("telescope").load_extension("jsonfly")
  end,
}
