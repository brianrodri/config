---@module "lazy"
---@type LazySpec
return {
  {
    "brianrodri/project.nvim",
    main = "project_nvim",
    ---@module "project_nvim"
    ---@type ProjectOptions
    opts = {
      detection_methods = { "lsp", "pattern" },
      exclude_dirs = {
        "~/.local/share/nvim/lazy", -- If I want to work on these then I'll clone them myself
        "~/Repositories/neovim", -- I cloned this to _build_ neovim, not to _contribute_ to it (for now)
      },
      patterns = { ".git" },
      show_hidden = true,
    },
    opts_extend = { "patterns" },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "brianrodri/project.nvim" },
    opts = { extensions = { projects = {} } },
    keys = {
      { "<leader>sp", function() require("telescope").extensions.projects.projects() end, desc = "Find Projects" },

      { "<leader>ps", function() require("telescope").extensions.projects.projects() end, desc = "Find Projects" },
      { "<leader>pr", function() require("project_nvim").get_recent_projects() end, desc = "Recent Projects" },
    },
  },
}
