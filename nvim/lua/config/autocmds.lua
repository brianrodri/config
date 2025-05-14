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

---@module "which-key"
---@type wk.Spec[]
--- Keymaps to attach to every LSP.
local LSP_WHICH_KEY_SPECS = {
  { "<leader>cr", function() vim.lsp.buf.rename() end, desc = "Rename Symbol" },
  { "<leader>ca", function() vim.lsp.buf.code_action() end, desc = "Code Action", mode = { "n", "x" } },
  { "<leader>c*", function() require("trouble").toggle("lsp_references") end, desc = "References" },
  { "<leader>cd", function() require("trouble").toggle("lsp_declarations") end, desc = "Declaration" },
  { "<leader>cD", function() require("trouble").toggle("lsp_definitions") end, desc = "Definitions" },
  { "<leader>cy", function() require("trouble").toggle("lsp_implementations") end, desc = "Implementations" },
  { "<leader>cY", function() require("trouble").toggle("lsp_type_definitions") end, desc = "Type Definitions" },
  { "<leader>cs", function() require("trouble").toggle("lsp_document_symbols") end, desc = "Document Symbols" },
  { "<leader>cj", function() require("trouble").toggle("lsp_incoming_calls") end, desc = "Incoming Calls" },
  { "<leader>ck", function() require("trouble").toggle("lsp_outgoing_calls") end, desc = "Outgoing Calls" },
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

-- Add toggle keymaps that need to wait for all plugins to load.
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local utils = require("my.utils")
    utils.var_toggle({ desc = "Auto Format", var_name = "autoformat", global = false }):map("<leader>oq")
    utils.var_toggle({ desc = "Auto Format", var_name = "autoformat", global = true }):map("<leader>oQ")
    local snacks = require("snacks")
    snacks.toggle.animate():map("<leader>om")
    snacks.toggle.option("colorcolumn", { on = "+1", off = "" }):map("<leader>oc")
    snacks.toggle.diagnostics():map("<leader>od")
    snacks.toggle.inlay_hints():map("<leader>oh")
    snacks.toggle.indent():map("<leader>oi")
    snacks.toggle.line_number():map("<leader>ol")
    snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>or")
    snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>os")
    snacks.toggle.treesitter():map("<leader>ot")
    snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>ow")
    snacks.toggle.zoom():map("<leader>oz")
    -- stylua: ignore
    -- luacheck: no max line length
    snacks.toggle({
      name = "Copilot",
      get = function() return not require("copilot.client").is_disabled() end,
      set = function(state) if state then require("copilot.command").enable() else require("copilot.command").disable() end end,
    }):map("<leader>oa")
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
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- Assign keymappings on LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-keymaps", { clear = true }),
  callback = function(args)
    local specs = vim
      .iter(LSP_WHICH_KEY_SPECS)
      :map(function(spec) return vim.tbl_extend("force", { buffer = args.buf }, spec) end)
      :totable()
    require("which-key").add(specs)
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
