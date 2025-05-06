---@module "lazy"
---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>f.",
      function() require("telescope.builtin").resume() end,
      desc = "Resume Finding",
    },
    {
      "<leader>f?",
      function() require("telescope.builtin").help_tags() end,
      desc = "Find Help Docs",
    },
    {
      "<leader>f*",
      function() require("telescope.builtin").grep_string() end,
      desc = "Find Word Under Cursor",
    },
    {
      "<leader>f/",
      function() require("telescope.builtin").live_grep() end,
      desc = "Grep Lines",
    },
    {
      "<leader>f:",
      function() require("telescope.builtin").commands() end,
      desc = "Find Commands",
    },
    {
      "<leader>fb",
      function() require("telescope.builtin").buffers() end,
      desc = "Find Buffers",
    },
    {
      "<leader>fc",
      function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end,
      desc = "Find Config Files",
    },
    {
      "<leader>ff",
      function() require("telescope.builtin").find_files() end,
      desc = "Find Files",
    },
    {
      "<leader>fk",
      function() require("telescope.builtin").keymaps() end,
      desc = "Find Keymaps",
    },
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("data") .. "/lazy/" })
      end,
      desc = "Find Plugin Files",
    },
    {
      "<leader>fr",
      function() require("telescope.builtin").oldfiles() end,
      desc = "Find Recent Files",
    },
    {
      "<leader>fs",
      function() require("telescope.builtin").builtin() end,
      desc = "Find Telescope Builtins",
    },
    {
      "<leader>fi",
      function() require("telescope").extensions.nerdy.nerdy() end,
      desc = "Find Nerd Font Icons",
    },
    {
      "<leader>fz",
      function() require("telescope.builtin").spell_suggest() end,
      desc = "Find Spelling Suggestions",
    },
    {
      "<leader>fg",
      function() require("telescope.builtin").git_files() end,
      desc = "Find Git Files",
    },
    {
      "<leader>fG",
      function() require("telescope.builtin").git_status() end,
      desc = "Find Changed Git Files",
    },
  },
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
