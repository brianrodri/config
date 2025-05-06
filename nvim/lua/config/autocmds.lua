---@module "which-key"
---@type wk.Spec[]
---Keymaps to attach to _every_ LSP.
local LSP_WHICH_KEY_SPECS = {
  {
    "<leader>cr",
    function() vim.lsp.buf.rename() end,
    desc = "Rename Symbol",
  },
  {
    "<leader>ca",
    function() vim.lsp.buf.code_action() end,
    desc = "Code Action",
    mode = { "n", "x" },
  },
  {
    "<leader>c*",
    function() require("trouble").toggle("lsp_references") end,
    desc = "References",
  },
  {
    "<leader>cd",
    function() require("trouble").toggle("lsp_declarations") end,
    desc = "Declaration",
  },
  {
    "<leader>cD",
    function() require("trouble").toggle("lsp_definitions") end,
    desc = "Definitions",
  },
  {
    "<leader>cy",
    function() require("trouble").toggle("lsp_implementations") end,
    desc = "Implementations",
  },
  {
    "<leader>cY",
    function() require("trouble").toggle("lsp_type_definitions") end,
    desc = "Type Definitions",
  },
  {
    "<leader>cs",
    function() require("trouble").toggle("lsp_document_symbols") end,
    desc = "Document Symbols",
  },
  {
    "<leader>cj",
    function() require("trouble").toggle("lsp_incoming_calls") end,
    desc = "Incoming Calls",
  },
  {
    "<leader>ck",
    function() require("trouble").toggle("lsp_outgoing_calls") end,
    desc = "Outgoing Calls",
  },
}

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
    if vim.opt_local.modifiable:get() then require("lint").try_lint() end
  end,
})
