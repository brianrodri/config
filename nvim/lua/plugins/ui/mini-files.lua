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

local function sync_or_go_in()
  local MiniFiles = require("mini.files")
  if not MiniFiles.synchronize() then MiniFiles.go_in({ close_on_file = true }) end
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
      synchronize = "<cr>",
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
        -- stylua: ignore
        -- luacheck: no max line length
        require("which-key").add({
          { "<C-l>", function() open_in_split("belowright vertical") end, desc = "Open On Right", buffer = buf_id },
          { "<C-j>", function() open_in_split("belowright horizontal") end, desc = "Open On Bottom", buffer = buf_id },
          { "<C-k>", function() open_in_split("aboveleft horizontal") end, desc = "Open On Top", buffer = buf_id },
          { "<C-h>", function() open_in_split("aboveleft vertical") end, desc = "Open On Left", buffer = buf_id },
          { "<cr>", sync_or_go_in, buffer = buf_id, hidden = true },
          { "q", function() require("mini.files").close() end, desc = "Close", buffer = buf_id },
          { "<esc>", function() require("mini.files").close() end, desc = "Close", buffer = buf_id },
        })
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
