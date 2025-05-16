return {
  name = vim.fn.has("wsl") == 1 and "wsl" or "macos",
}
