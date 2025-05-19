local Path = require("my.utils.path")

---@module "lazy"
---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  -- stylua: ignore
  -- luacheck: no max line length
  keys = {
    { "<leader>s.", function() require("telescope.builtin").resume() end, desc = "Resume Finding" },
    { "<leader>s?", function() require("telescope.builtin").help_tags() end, desc = "Find Help Docs" },
    { "<leader>s*", function() require("telescope.builtin").grep_string() end, desc = "Find Word Under Cursor" },
    { "<leader>s/", function() require("telescope.builtin").live_grep() end, desc = "Grep Lines" },
    { "<leader>s:", function() require("telescope.builtin").commands() end, desc = "Find Commands" },
    { "<leader>sb", function() require("telescope.builtin").buffers() end, desc = "Find Buffers" },
    { "<leader>sc", function() require("telescope.builtin").find_files({ cwd = Path.stdpath("config").path, follow = true }) end, desc = "Find Config Files" },
    { "<leader>sf", function() require("telescope.builtin").find_files({ follow = true }) end, desc = "Find Files" },
    { "<leader>sh", function() require("telescope.builtin").highlights() end, desc = "Find Highlights" },
    { "<leader>sk", function() require("telescope.builtin").keymaps() end, desc = "Find Keymaps" },
    { "<leader>sl", function() require("telescope.builtin").find_files({ cwd = Path.stdpath("data"):join("lazy").path, follow = true }) end, desc = "Find Lazy Files" },
    { "<leader>sr", function() require("telescope.builtin").oldfiles() end, desc = "Find Recent Files" },
    { "<leader>ss", function() require("telescope.builtin").builtin() end, desc = "Find Telescope Builtins" },
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
}
