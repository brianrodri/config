local LAZY_PATH = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(LAZY_PATH) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, LAZY_PATH })
  if vim.v.shell_error ~= 0 then error("Error cloning lazy.nvim:\n" .. out) end
end

---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(LAZY_PATH)

require("lazy").setup({ import = "plugins" })
