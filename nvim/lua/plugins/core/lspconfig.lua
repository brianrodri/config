---@class my.LspConfig: { [string]: vim.lsp.Config }

---@module "lazy"
---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  ---@param opts my.LspConfig
  config = function(_, opts)
    for name, config in pairs(opts or {}) do
      if config then vim.lsp.enable(name, true) end
      if type(config) == "table" and not vim.tbl_isempty(config) then vim.lsp.config(name, config) end
    end
  end,
}
