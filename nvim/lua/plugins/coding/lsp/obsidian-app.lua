local workspaces = {
    { name = "personal", path = "~/Documents/Vault" },
}

return {
    "obsidian-nvim/obsidian.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = vim.iter(workspaces)
        :map(function(vault) return vim.fn.expand(vault.path) .. "/*" end)
        :map(function(pattern) return { "BufReadPre " .. pattern, "BufNewFile " .. pattern } end)
        :flatten()
        :totable(),
    opts = { workspaces = workspaces },
    lazy = true,
}
