local TODO_TAGS = { "fix", "todo", "hack", "perf", "warn" }

local todo_filter = function(items)
  return vim.tbl_filter(function(i) return vim.tbl_contains(TODO_TAGS, string.lower(i.tag)) end, items)
end

---@module "lazy"
---@type LazySpec
return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  ---@type trouble.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    follow = false,
    pinned = true,
    focus = true,
    multiline = false,
    warn_no_results = false,
    open_no_results = true,
    preview = { scratch = false },
    ---@type table<string, trouble.Mode>
    modes = {
      ---@diagnostic disable-next-line: missing-fields
      my_lsp_document_symbols = {
        mode = "lsp_document_symbols",
        win = { position = "right", size = 80, minimal = true },
      },
    },
  },
  keys = {
    { "<leader>xx", function() require("trouble").toggle("diagnostics") end, desc = "Diagnostics" },
    {
      "<leader>xt",
      ---@diagnostic disable-next-line: missing-fields
      function() require("trouble").toggle({ mode = "todo", filter = todo_filter }) end,
      desc = "Todo",
    },
    { "<leader>xq", function() require("trouble").toggle("qflist") end, desc = "QuickFix List" },
    { "<leader>xl", function() require("trouble").toggle("loclist") end, desc = "Location List" },
    { "<leader>xm", "<cmd>NoiceAll<cr>", desc = "Messages" },
  },
}
