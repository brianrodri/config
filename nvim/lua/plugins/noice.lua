--- @module "lazy"
--- @type LazySpec
return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",

            {
                "nvim-treesitter/nvim-treesitter",
                opts = { ensure_installed = { "bash" } },
                opts_extend = { "ensure_installed" },
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            lsp_doc_border = true,
        },
    },
}
