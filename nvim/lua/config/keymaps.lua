local M = {}

function M.set_formatter_keymaps(get, set)
    local conform = require("conform")
    local snacks = require("snacks")
    require("which-key").add({ "<leader>cf", function() conform.format({ lsp_format = "fallback" }) end, desc = "Format buffer" })
    snacks.toggle({ name = "Auto Format (buffer)", get = get, set = function(enable) set(enable, false) end }):map("<leader>of")
    snacks.toggle({ name = "Auto Format (global)", get = get, set = function(enable) set(enable, true) end }):map("<leader>oF")
end

function M.set_toggle_keymaps()
    local snacks = require("snacks")
    require("which-key").add({ "<leader>o", group = "toggle" })
    snacks.toggle.animate():map("<leader>oa")
    snacks.toggle.diagnostics():map("<leader>od")
    snacks.toggle.indent():map("<leader>oi")
    snacks.toggle.line_number():map("<leader>ol")
    snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>or")
    snacks.toggle.scroll():map("<leader>os")
    snacks.toggle.treesitter():map("<leader>ot")
    snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>ow")
    snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>oz")
end

function M.set_global_keymaps()
    local snacks = require("snacks")
    require("which-key").add({
        { "<esc>", function() vim.cmd([[nohlsearch]]) end },

        { "<leader>q", group = "quit" },
        { "<leader>qq", ":qa!<CR>", desc = "Quit without saving" },
        { "<leader>qw", ":wqa!<CR>", desc = "Save all and quit" },

        { "<leader>b", group = "buffer" },
        { "<leader>bd", function() snacks.bufdelete.delete() end },
    })
    M.set_toggle_keymaps()
end

function M.set_dap_keymaps()
    local dap = require("dap")
    local dapui = require("dapui")
    local widgets = require("dap.ui.widgets")
    require("which-key").add({
        { "<leader>d", group = "debug" },
        { "<leader>dn", function() dap.continue() end, desc = "Start/Resume debug session" },
        { "<leader>d.", function() dap.run_last() end, desc = "Restart debug session" },
        { "<leader>dl", function() dap.step_over() end, desc = "Step over" },
        { "<leader>dj", function() dap.step_into() end, desc = "Step into" },
        { "<leader>dk", function() dap.step_out() end, desc = "Step out" },
        { "<leader>dr", function() dap.repl.toggle() end, desc = "Toggle debug REPL" },
        { "<leader>db", function() dap.toggle_breakpoint() end, desc = "Toggle breakpoint" },
        { "<leader>du", function() dapui.toggle() end, desc = "Toggle DAPUI" },
        { "<leader>dK", function() widgets.hover() end, desc = "Show hover", mode = { "n", "v" } },
        { "<leader>dp", function() widgets.preview() end, desc = "Show preview", mode = { "n", "v" } },
        { "<leader>df", function() widgets.centered_float(widgets.frames) end, desc = "Show frames" },
        { "<leader>ds", function() widgets.centered_float(widgets.scopes) end, desc = "Show scopes" },
    })
end

function M.set_git_keymaps(bufnr)
    local gitsigns = require("gitsigns")
    local telescope_builtin = require("telescope.builtin")
    local which_key = require("which-key")
    local snacks_lazygit = require("snacks.lazygit")

    which_key.add({
        -- Finding
        { "<leader>fg", function() telescope_builtin.git_files() end, desc = "Find git files" },
        { "<leader>fG", function() telescope_builtin.git_status() end, desc = "Find changed git files" },

        -- Motions
        { "]g", function() gitsigns.nav_hunk("next") end, desc = "Jump to next hunk" },
        { "[g", function() gitsigns.nav_hunk("prev") end, desc = "Jump to previous hunk" },

        -- Interfaces
        { "<leader>g", group = "git" },
        { "<leader>gg", function() snacks_lazygit.open() end, desc = "Lazygit" },
        { "<leader>ga", function() gitsigns.stage_hunk() end, desc = "Stage hunk" },
        { "<leader>gr", function() gitsigns.reset_hunk() end, desc = "Reset hunk" },
        { "<leader>gA", function() gitsigns.stage_buffer() end, desc = "Stage buffer" },
        { "<leader>gR", function() gitsigns.reset_buffer() end, desc = "Reset buffer" },
        { "<leader>gp", function() gitsigns.preview_hunk_inline() end, desc = "Preview hunk (inline)" },
        { "<leader>gP", function() gitsigns.preview_hunk() end, desc = "Preview hunk" },
        { "<leader>gd", function() gitsigns.diffthis() end, desc = "Diff against index" },
        { "<leader>gD", function() gitsigns.diffthis("main") end, desc = "Diff against main" },
        { "<leader>gb", function() gitsigns.toggle_current_line_blame() end, desc = "Toggle blame" },

        { "<leader>ga", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, desc = "git [s]tage hunk", mode = "v" },
        { "<leader>gr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, desc = "git [r]eset hunk", mode = "v" },
    }, { buffer = bufnr })
end

function M.set_lsp_keymaps(client, event)
    local builtins = require("telescope.builtin")
    local snacks = require("snacks")
    require("which-key").add({
        { "<leader>c", group = "code" },
        { "<leader>cr", function() vim.lsp.buf.rename() end, desc = "Rename symbol", buffer = event.buf },
        { "<leader>ca", function() vim.lsp.buf.code_action() end, desc = "Code action", mode = { "n", "x" }, buffer = event.buf },
        { "<leader>c*", function() builtins.lsp_references() end, desc = "Symbol references", buffer = event.buf },
        { "<leader>cd", function() builtins.lsp_definitions() end, desc = "Symbol definition", buffer = event.buf },
        { "<leader>ci", function() vim.lsp.buf.declaration() end, desc = "Symbol declaration", buffer = event.buf },
        { "<leader>cI", function() builtins.lsp_implementations() end, desc = "Symbol implementation", buffer = event.buf },
        { "<leader>cy", function() builtins.lsp_type_definitions() end, desc = "[G]oto [T]ype Definition", buffer = event.buf },

        { "<leader>c/", function() builtins.lsp_document_symbols() end, desc = "Find document symbols", buffer = event.buf },
        { "<leader>fw", function() builtins.lsp_dynamic_workspace_symbols() end, desc = "Find workspace symbols", buffer = event.buf },
    })

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then snacks.toggle.inlay_hints():map("<leader>oh") end
end

function M.set_telescope_keymaps()
    local telescope = require("telescope")
    local telescope_builtin = require("telescope.builtin")
    require("which-key").add({
        { "<leader>f", group = "find", icon = "" },
        { "<leader>f?", function() telescope_builtin.help_tags() end, desc = "Find help docs" },
        { "<leader>f.", function() telescope_builtin.resume() end, desc = "Resume last search" },
        { "<leader>f*", function() telescope_builtin.grep_string() end, desc = "Find word under cursor" },
        { "<leader>f/", function() telescope_builtin.live_grep() end, desc = "Grep files with input pattern" },
        { "<leader>fb", function() telescope_builtin.buffers() end, desc = "Find buffers" },
        { "<leader>fc", function() telescope_builtin.find_files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find nvim config" },
        { "<leader>fd", function() telescope_builtin.diagnostics() end, desc = "Find workspace diagnostics" },
        { "<leader>ff", function() telescope_builtin.find_files() end, desc = "Find files in current directory" },
        { "<leader>fk", function() telescope_builtin.keymaps() end, desc = "Find keymaps" },
        { "<leader>fl", function() telescope_builtin.oldfiles() end, desc = "Find last opened files" },
        { "<leader>fs", function() telescope_builtin.builtin() end, desc = "Find telescope builtins" },
        { "<leader>fi", function() telescope.extensions.nerdy.nerdy() end, desc = "Find nerd font icons" },
    })
end

function M.set_neo_tree_keymaps()
    local neotree_command = require("neo-tree.command")
    require("which-key").add({
        { "<leader>n", group = "neotree", icon = "󰙅 " },
        { "<leader>nf", function() neotree_command.execute({ source = "filesystem", toggle = true }) end, desc = "Open file system tree" },
        { "<leader>nb", function() neotree_command.execute({ source = "buffers", toggle = true }) end, desc = "Open buffers tree" },
        { "<leader>ng", function() neotree_command.execute({ source = "git_status", toggle = true }) end, desc = "Open git status tree" },
        { "<leader>nm", function() neotree_command.execute({ source = "migrations", toggle = true }) end, desc = "Open migration tree" },
    })
end

function M.set_neotest_keymaps()
    local neotest = require("neotest")
    require("which-key").add({
        { "<leader>t", group = "test", icon = "󰙨 " },
        { "<leader>tt", function() neotest.run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
        { "<leader>tT", function() neotest.run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
        { "<leader>t*", function() neotest.run.run() end, desc = "Run Nearest (Neotest)" },
        { "<leader>td", function() neotest.run.run({ strategy = "dap" }) end, desc = "Run File (Neotest)" },
        { "<leader>tl", function() neotest.run.run_last() end, desc = "Run Last (Neotest)" },
        { "<leader>ts", function() neotest.summary.toggle() end, desc = "Toggle Summary (Neotest)" },
        { "<leader>to", function() neotest.output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
        { "<leader>tO", function() neotest.output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
        { "<leader>tq", function() neotest.run.stop() end, desc = "Stop (Neotest)" },
        { "<leader>tw", function() neotest.watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
    })
end

return M
