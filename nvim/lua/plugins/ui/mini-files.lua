local function open_in_split(direction)
  local MiniFiles = require("mini.files")
  local cur_target = MiniFiles.get_explorer_state().target_window
  local new_target = vim.api.nvim_win_call(cur_target, function()
    vim.cmd(direction .. " split")
    return vim.api.nvim_get_current_win()
  end)
  MiniFiles.set_target_window(new_target)
  MiniFiles.go_in({ close_on_file = true })
end

---@module "lazy"
---@type LazySpec
return {
  -- TODO(echasnovski/mini.nvim#1816): switch back to "echasnovski/mini.nvim"
  "brianrodri/mini.nvim",
  main = "mini.files",
  opts = {
    windows = {
      preview = true,
      width_focus = 32,
      width_nofocus = 16,
      width_preview = 64,
    },
    mappings = {
      close = "-",
      go_in = "",
      go_in_plus = "L",
      go_out = "",
      go_out_plus = "H",
      reset = "<c-c>",
      reveal_cwd = "g.",
      synchronize = "=",
      trim_left = "<c-h>",
      trim_right = "<c-l>",
    },
  },
  keys = {
    { "-", function() require("mini.files").open(vim.api.nvim_buf_get_name(0)) end, { desc = "Open Directory" } },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(event)
        local buf_id = event.data.buf_id
        local buf_keymap = function(lhs, rhs, desc) vim.keymap.set("n", lhs, rhs, { desc = desc, buffer = buf_id }) end
        buf_keymap("<C-l>", function() open_in_split("belowright vertical") end, "Open to right")
        buf_keymap("<C-j>", function() open_in_split("belowright horizontal") end, "Open to bottom")
        buf_keymap("<C-k>", function() open_in_split("aboveleft horizontal") end, "Open to top")
        buf_keymap("<C-h>", function() open_in_split("aboveleft vertical") end, "Open to left")
        buf_keymap("<cr>", function() require("mini.files").go_in({ close_on_file = true }) end, "Go in entry plus")
        buf_keymap("q", function() require("mini.files").close() end, "Close")
        buf_keymap("<esc>", function() require("mini.files").close() end, "Close")
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesActionRename",
      callback = function(event)
        vim.schedule(function() require("snacks.rename").on_rename_file(event.data.from, event.data.to) end)
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesActionDelete",
      callback = function(event)
        vim.schedule(function() require("snacks.bufdelete").delete({ file = event.data.from }) end)
      end,
    })
  end,
}
