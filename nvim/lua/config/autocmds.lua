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
    require("which-key").add({
      {
        "<leader>cr",
        function() vim.lsp.buf.rename() end,
        desc = "Rename Symbol",
        buffer = args.buf,
      },
      {
        "<leader>ca",
        function() vim.lsp.buf.code_action() end,
        desc = "Code Action",
        mode = { "n", "x" },
        buffer = args.buf,
      },
      {
        "<leader>c*",
        function() require("trouble").toggle("lsp_references") end,
        desc = "References",
        buffer = args.buf,
      },
      {
        "<leader>cd",
        function() require("trouble").toggle("lsp_declarations") end,
        desc = "Declaration",
        buffer = args.buf,
      },
      {
        "<leader>cD",
        function() require("trouble").toggle("lsp_definitions") end,
        desc = "Definitions",
        buffer = args.buf,
      },
      {
        "<leader>cy",
        function() require("trouble").toggle("lsp_implementations") end,
        desc = "Implementations",
        buffer = args.buf,
      },
      {
        "<leader>cY",
        function() require("trouble").toggle("lsp_type_definitions") end,
        desc = "Type Definitions",
        buffer = args.buf,
      },
      {
        "<leader>cs",
        function() require("trouble").toggle("lsp_document_symbols") end,
        desc = "Document Symbols",
        buffer = args.buf,
      },
      {
        "<leader>cj",
        function() require("trouble").toggle("lsp_incoming_calls") end,
        desc = "Incoming Calls",
        buffer = args.buf,
      },
      {
        "<leader>ck",
        function() require("trouble").toggle("lsp_outgoing_calls") end,
        desc = "Outgoing Calls",
        buffer = args.buf,
      },
    })
  end,
})

-- Automatically format on-write
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("lint", { clear = true }),
  callback = function()
    if vim.opt_local.modifiable:get() then require("lint").try_lint() end
  end,
})
