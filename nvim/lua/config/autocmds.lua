local Funcs = require("my.utils.funcs")

---@type string[]
--- File types that can be closed by pressing "q" in normal mode.
local CLOSE_WITH_Q = {
  "PlenaryTestPopup",
  "checkhealth",
  "dbout",
  "gitsigns-blame",
  "grug-far",
  "help",
  "lspinfo",
  "neotest-output",
  "neotest-output-panel",
  "neotest-summary",
  "notify",
  "qf",
  "spectre_panel",
  "startuptime",
  "tsplayground",
}

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = CLOSE_WITH_Q,
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      local close_buffer = function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end
      vim.keymap.set("n", "q", close_buffer, { buffer = event.buf, silent = true, desc = "Close Buffer" })
    end)
  end,
})

-- Setup complex keymaps that depend on 2+ *independent* plugins to be implemented.
vim.api.nvim_create_autocmd("User", {
  once = true,
  nested = true,
  pattern = "VeryLazy",
  desc = "Setup complex keymaps",
  callback = function()
    local toggle = require("snacks.toggle")
    Funcs.var_toggle({ desc = "Auto Format", var_name = "autoformat", global = false }):map("<leader>oq")
    Funcs.var_toggle({ desc = "Auto Format", var_name = "autoformat", global = true }):map("<leader>oQ")
    toggle.option("colorcolumn", { name = "Color Column", on = "+1", off = "" }):map("<leader>oc")
    toggle.diagnostics():map("<leader>od")
    toggle.inlay_hints():map("<leader>oh")
    toggle.indent():map("<leader>oi")
    toggle.line_number():map("<leader>ol")
    toggle.animate():map("<leader>om")
    toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>or")
    toggle.option("spell", { name = "Spelling" }):map("<leader>os")
    toggle.treesitter():map("<leader>ot")
    toggle.option("wrap", { name = "Wrap" }):map("<leader>ow")
    toggle.zoom():map("<leader>oz")
  end,
})

-- Make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("man_unlisted", { clear = true }),
  pattern = { "man" },
  callback = function(event) vim.bo[event.buf].buflisted = false end,
})

-- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  desc = "Highlight when yanking text",
  callback = function() vim.highlight.on_yank() end,
})

-- Assign keymaps on LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-keymaps", { clear = true }),
  callback = function(args)
    -- stylua: ignore
    -- luacheck: no max line length
    require("which-key").add({
      { "<leader>cr", function() vim.lsp.buf.rename() end, buffer = args.buf, desc = "Rename Symbol" },
      { "<leader>ca", function() vim.lsp.buf.code_action() end, buffer = args.buf, desc = "Code Action", mode = { "n", "x" } },
      { "<leader>c*", function() require("trouble").toggle("lsp_references") end, buffer = args.buf, desc = "References" },
      { "<leader>cd", function() require("trouble").toggle("lsp_declarations") end, buffer = args.buf, desc = "Declaration" },
      { "<leader>cD", function() require("trouble").toggle("lsp_definitions") end, buffer = args.buf, desc = "Definitions" },
      { "<leader>cy", function() require("trouble").toggle("lsp_implementations") end, buffer = args.buf, desc = "Implementations" },
      { "<leader>cY", function() require("trouble").toggle("lsp_type_definitions") end, buffer = args.buf, desc = "Type Definitions" },
      { "<leader>cs", function() require("trouble").toggle("my_lsp_document_symbols") end, buffer = args.buf, desc = "Document Symbols" },
      { "<leader>cj", function() require("trouble").toggle("lsp_incoming_calls") end, buffer = args.buf, desc = "Incoming Calls" },
      { "<leader>ck", function() require("trouble").toggle("lsp_outgoing_calls") end, buffer = args.buf, desc = "Outgoing Calls" },
    }, { create = true })
  end,
})

-- Automatically format on-write
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("lint", { clear = true }),
  callback = function()
    local ok, lint = pcall(require, "lint")
    if ok and vim.opt_local.modifiable:get() then lint.try_lint() end
  end,
})

-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end
  end,
})
