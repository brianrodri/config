local Fmt = require("my.utils.fmt")

local M = {
  -- NOTE: TODO's definition is intentionally inconsistent so that tools don't consider it to be an _actual_ TODO.

  --- Terminates the last protected call with a helpful "not implemented" error.
  ---
  ---@param func_name string  The name of the unimplemented function.
  ---@param ... any           The arguments passed to the function.
  ---@return unknown ...      Although this function never returns, the annotation convinces LuaLS that it does.
  TODO = function(func_name, ...) error(Fmt.call_error("not implemented", func_name, ...)) end,
}

--- Joins the error objects into a string. Returns `nil` when no errors are passed.
---
---@param ... unknown|?  The error objects to join. `nil` values are skipped.
---@return string|?
function M.join(...)
  -- NOTE: `:h Iter:map()` skips over `nil` return values.
  local errs = vim.iter({ ... }):map(function(err) return err and tostring(err) end):totable()
  if #errs == 0 then return nil end
  if #errs == 1 then return errs[1] end
  return vim.iter(errs):map(function(err) return "\t" .. err end):join("\n")
end

return M
