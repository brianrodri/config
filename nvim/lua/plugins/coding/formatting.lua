local keymaps = require("config.keymaps")

local function is_enabled(buf)
    if buf == nil or buf == 0 then buf = vim.api.nvim_get_current_buf() end
    if vim.b[buf].autoformat ~= nil then return vim.b[buf].autoformat end
    if vim.g.autoformat ~= nil then return vim.g.autoformat end
    return true
end

local function set_enabled(enable, global)
    if global then
        vim.g.autoformat = enable
        vim.b.autoformat = nil
    else
        vim.b.autoformat = enable
    end
end

return { -- Autoformat
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = function() return keymaps.set_formatter_keymaps(is_enabled, set_enabled) end,
    opts = {
        format_on_save = function(buf)
            if is_enabled(buf) then return { timeout_ms = 500, lsp_format = "fallback" } end
            return nil
        end,
        formatters_by_ft = {
            lua = { "stylua" },
            markdown = { "markdownlint" },
            typescript = { "prettier" },
        },
    },
}
