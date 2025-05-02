return {
    -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
        { "j-hui/fidget.nvim", opts = {} },
        "saghen/blink.cmp",
    },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                require("config.keymaps").set_lsp_keymaps(client, event)
                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                    local highlight_group = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
                    vim.api.nvim_create_autocmd(
                        { "CursorHold", "CursorHoldI" },
                        { buffer = event.buf, group = highlight_group, callback = vim.lsp.buf.document_highlight }
                    )
                    vim.api.nvim_create_autocmd(
                        { "CursorMoved", "CursorMovedI" },
                        { buffer = event.buf, group = highlight_group, callback = vim.lsp.buf.clear_references }
                    )

                    local detach_group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true })
                    vim.api.nvim_create_autocmd("LspDetach", {
                        group = detach_group,
                        callback = function(detach_event)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = detach_event.buf })
                        end,
                    })
                end
            end,
        })

        vim.diagnostic.config({
            severity_sort = true,
            float = { border = "rounded", source = "if_many" },
            virtual_text = { spacing = 2, source = "if_many" },
        })

        local capabilities = require("blink.cmp").get_lsp_capabilities()

        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        completion = { callSnippet = "Replace" },
                        diagnostics = { disable = { "missing-fields" } },
                    },
                },
            },
        }
    end,
}
