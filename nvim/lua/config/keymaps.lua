local M = {}

function M.set_global_keymaps()
    local snacks = require("snacks")
    require("which-key").add({
        { "<esc>", function() vim.cmd([[nohlsearch]]) end },
        { "ZA", ":qa!<CR>", desc = "Quit Without Saving" },

        { "<leader>b", group = "buffer" },
        { "<leader>bd", function() snacks.bufdelete.delete() end },
    })
    M.set_toggle_keymaps()
    M.set_git_keymaps()
end

function M.set_formatter_keymaps(get, set)
    local conform = require("conform")
    local snacks = require("snacks")
    require("which-key").add({ "<leader>cq", function() conform.format({ lsp_format = "fallback" }) end, desc = "Format Buffer" })
    snacks.toggle({ name = "Auto Format (buffer)", get = function() return get(false) end, set = function(enable) set(enable, false) end }):map("<leader>oq")
    snacks.toggle({ name = "Auto Format (global)", get = function() return get(true) end, set = function(enable) set(enable, true) end }):map("<leader>oQ")
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

function M.set_dap_keymaps()
    local dap = require("dap")
    local dapui = require("dapui")
    local widgets = require("dap.ui.widgets")
    require("which-key").add({
        { "<leader>d", group = "debug" },
        { "<leader>dn", function() dap.continue() end, desc = "Start/Resume" },
        { "<leader>d.", function() dap.run_last() end, desc = "Restart" },
        { "<leader>dl", function() dap.step_over() end, desc = "Step Over" },
        { "<leader>dj", function() dap.step_into() end, desc = "Step Into" },
        { "<leader>dk", function() dap.step_out() end, desc = "Step Out" },
        { "<leader>dr", function() dap.repl.toggle() end, desc = "Toggle REPL" },
        { "<leader>db", function() dap.toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<leader>du", function() dapui.toggle() end, desc = "Toggle UI" },
        { "<leader>dK", function() widgets.hover() end, desc = "Show Hover", mode = { "n", "v" } },
        { "<leader>dp", function() widgets.preview() end, desc = "Show Preview", mode = { "n", "v" } },
        { "<leader>df", function() widgets.centered_float(widgets.frames) end, desc = "Show Frames" },
        { "<leader>ds", function() widgets.centered_float(widgets.scopes) end, desc = "Show Scopes" },
    })
end

function M.set_git_keymaps()
    local gitsigns = require("gitsigns")
    local telescope_builtin = require("telescope.builtin")
    local which_key = require("which-key")
    local snacks_lazygit = require("snacks.lazygit")

    which_key.add({
        { "<leader>fg", function() telescope_builtin.git_files() end, desc = "Find Git Files" },
        { "<leader>fG", function() telescope_builtin.git_status() end, desc = "Find Changed Git Files" },

        { "]g", function() gitsigns.nav_hunk("next") end, desc = "Jump To Next Hunk" },
        { "[g", function() gitsigns.nav_hunk("prev") end, desc = "Jump To Previous Hunk" },

        { "<leader>g", group = "git" },
        { "<leader>gg", function() snacks_lazygit.open() end, desc = "Lazygit" },
        { "<leader>ga", function() gitsigns.stage_hunk() end, desc = "Stage Hunk" },
        { "<leader>gc", "<cmd>Git commit<cr>", desc = "Commit" },
        { "<leader>gp", "<cmd>Git push<cr>", desc = "Push" },
        { "<leader>gl", "<cmd>Git pull<cr>", desc = "Pull" },
        { "<leader>gs", "<cmd>Git<cr>", desc = "Pull" },
        { "<leader>gr", function() gitsigns.reset_hunk() end, desc = "Reset Hunk" },
        { "<leader>gA", function() gitsigns.stage_buffer() end, desc = "Stage Buffer" },
        { "<leader>gR", function() gitsigns.reset_buffer() end, desc = "Reset Buffer" },
        { "<leader>gK", function() gitsigns.preview_hunk() end, desc = "Preview Hunk" },
        { "<leader>gd", function() gitsigns.diffthis() end, desc = "Diff Against Index" },
        { "<leader>gD", function() gitsigns.diffthis("main") end, desc = "Diff Against Main" },
        { "<leader>gb", function() gitsigns.toggle_current_line_blame() end, desc = "Toggle Blame" },

        { "<leader>ga", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, desc = "Stage Hunk", mode = "v" },
        { "<leader>gr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, desc = "Reset Hunk", mode = "v" },
    })
end

function M.set_lsp_keymaps(client, buffer)
    local telescope_builtin = require("telescope.builtin")
    require("which-key").add({
        { "<leader>c", group = "code", icon = " " },
        { "<leader>cr", function() vim.lsp.buf.rename() end, desc = "Rename Symbol", buffer = buffer },
        { "<leader>ca", function() vim.lsp.buf.code_action() end, desc = "Code Action", mode = { "n", "x" }, buffer = buffer },
        { "<leader>ci", function() telescope_builtin.lsp_incoming_calls() end, desc = "Incoming Calls", buffer = buffer },
        { "<leader>co", function() telescope_builtin.lsp_outgoing_calls() end, desc = "Outgoing Calls", buffer = buffer },
        { "<leader>c*", function() telescope_builtin.lsp_references() end, desc = "References", buffer = buffer },
        { "<leader>cd", function() vim.lsp.buf.declaration() end, desc = "Declaration", buffer = buffer },
        { "<leader>cD", function() telescope_builtin.lsp_definitions() end, desc = "Definitions", buffer = buffer },
        { "<leader>cy", function() telescope_builtin.lsp_implementations() end, desc = "Implementations", buffer = buffer },
        { "<leader>cY", function() telescope_builtin.lsp_type_definitions() end, desc = "Type Definitions", buffer = buffer },
        { "<leader>cf", function() telescope_builtin.lsp_document_symbols() end, desc = "Document Symbols", buffer = buffer },
        { "<leader>cF", function() telescope_builtin.lsp_dynamic_workspace_symbols() end, desc = "Workspace Symbols", buffer = buffer },
        {
            "<leader>oh",
            function()
                local enabled = not vim.lsp.inlay_hint.is_enabled()
                vim.lsp.inlay_hint.enable(enabled)
                vim.notify(enabled and "Enabled **Inlay Hints**" or "Disabled **Inlay Hints**", enabled and vim.log.levels.INFO or vim.log.levels.WARN)
            end,
            icon = function() return vim.lsp.inlay_hint.is_enabled() and { icon = " ", color = "green" } or { icon = " ", color = "yellow" } end,
            desc = function() return vim.lsp.inlay_hint.is_enabled() and "Disable Inlay Hints" or "Enable Inlay Hints" end,
            cond = client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, buffer),
            buffer = buffer,
        },
    })
end

function M.get_telescope_mappings()
    local telescope = require("telescope")
    local telescope_builtin = require("telescope.builtin")
    require("which-key").add({
        { "<leader>f", group = "find", icon = " " },
        { "<leader>f.", function() telescope_builtin.resume() end, desc = "Resume Finding" },
        { "<leader>f?", function() telescope_builtin.help_tags() end, desc = "Find Help Docs" },
        { "<leader>f*", function() telescope_builtin.grep_string() end, desc = "Find Word Under Cursor" },
        { "<leader>f/", function() telescope_builtin.live_grep() end, desc = "Grep Lines" },
        { "<leader>f:", function() telescope_builtin.commands() end, desc = "Find Commands" },
        { "<leader>fb", function() telescope_builtin.buffers() end, desc = "Find Buffers" },
        { "<leader>fc", function() telescope_builtin.find_files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config Files" },
        { "<leader>fd", function() telescope_builtin.diagnostics() end, desc = "Find Diagnostics" },
        { "<leader>ff", function() telescope_builtin.find_files() end, desc = "Find Files" },
        { "<leader>fk", function() telescope_builtin.keymaps() end, desc = "Find Keymaps" },
        { "<leader>fr", function() telescope_builtin.oldfiles() end, desc = "Find Recent Files" },
        { "<leader>fs", function() telescope_builtin.builtin() end, desc = "Find Telescope Builtins" },
        { "<leader>fi", function() telescope.extensions.nerdy.nerdy() end, desc = "Find Nerd Font Icons" },
        { "<leader>fz", function() telescope_builtin.spell_suggest() end, desc = "Find Spelling Suggestions" },
    })
end

function M.set_neo_tree_keymaps()
    local neotree_command = require("neo-tree.command")
    require("which-key").add({
        { "<leader>n", group = "neotree", icon = "󰙅 " },
        { "<leader>nf", function() neotree_command.execute({ source = "filesystem", toggle = true, reveal = true }) end, desc = "Open File System Tree" },
        { "<leader>nb", function() neotree_command.execute({ source = "buffers", toggle = true, reveal = true }) end, desc = "Open Buffers Tree" },
        { "<leader>ng", function() neotree_command.execute({ source = "git_status", toggle = true, reveal = true }) end, desc = "Open Git Status Tree" },
        { "<leader>nm", function() neotree_command.execute({ source = "migrations", toggle = true, reveal = true }) end, desc = "Open Migrations Tree" },
    })
end

function M.set_neotest_keymaps()
    local neotest = require("neotest")
    require("which-key").add({
        { "<leader>t", group = "test", icon = "󰙨 " },
        { "<leader>tt", function() neotest.run.run(vim.fn.expand("%")) end, desc = "Test File" },
        { "<leader>tT", function() neotest.run.run(vim.uv.cwd()) end, desc = "Test All Files" },
        { "<leader>t*", function() neotest.run.run() end, desc = "Test Nearest" },
        { "<leader>td", function() neotest.run.run({ vim.fn.expand("%"), strategy = "dap", suite = true }) end, desc = "Test File With DAP" },
        { "<leader>tl", function() neotest.run.run_last() end, desc = "Test Recent" },
        { "<leader>ts", function() neotest.summary.toggle() end, desc = "Toggle Summary" },
        { "<leader>to", function() neotest.output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
        { "<leader>tO", function() neotest.output_panel.toggle() end, desc = "Toggle Output Panel" },
        { "<leader>tq", function() neotest.run.stop() end, desc = "Stop" },
        { "<leader>tw", function() neotest.watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch" },
    })
end

function M.set_trouble_keymaps()
    local trouble = require("trouble")
    require("which-key").add({
        { "<leader>x", group = "trouble", icon = { icon = "󱍼 ", hl = "TSError" } },
        { "<leader>xx", function() trouble.toggle("diagnostics") end, desc = "Diagnostics" },
    })
end

---@param client vim.lsp.Client
---@param buffer integer?
function M.set_obsidian_keymaps(client, buffer)
    local open_daily_note = function()
        local input = vim.fn.input("Open Daily Note", "today")
        if input then client:exec_cmd({ title = "Open Daily Note", command = "jump", arguments = { input } }) end
    end

    require("which-key").add({
        { "<leader>j", group = "journal", icon = "󰠮 ", buffer = buffer },
        { "<leader>jd", open_daily_note, desc = "Open Daily Note", buffer = buffer },
        { "<leader>jf", "<cmd>ObsidianSearch<cr>", desc = "Find Note", buffer = buffer },
        { "<leader>jn", "<cmd>ObsidianNew<CR>", desc = "New Note", buffer = buffer },
    })
end

return M
