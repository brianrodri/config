---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      textobjects = {
        swap = {
          enable = true,
          swap_next = { ["]S"] = "@parameter.inner" },
          swap_previous = { ["[S"] = "@parameter.inner" },
        },
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
        lsp_interop = {
          enable = true,
          border = "none",
          peek_definition_code = {
            ["<leader>cC"] = "@class.outer",
            ["<leader>cF"] = "@function.outer",
          },
        },
      },
    },
  },
}
