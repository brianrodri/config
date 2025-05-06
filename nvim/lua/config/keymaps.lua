-- Clear Search Highlighting
vim.keymap.set("n", "<esc>", function() vim.cmd([[nohlsearch]]) end)

-- Buffer controls
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>bd", function() require("snacks").bufdelete() end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- File controls
vim.keymap.set("n", "<leader>fw", "<cmd>w<cr><esc>", { desc = "Save File" })
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Lazy controls
vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy" })
vim.keymap.set("n", "<leader>ls", "<cmd>Lazy sync<cr>", { desc = "Lazy Sync" })

-- Lazygit
vim.keymap.set("n", "<leader>gg", function() require("snacks").lazygit() end, { desc = "Lazygit" })

-- Quit
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>qw", "<cmd>wa | qa<cr>", { desc = "Quit & Save All" })
