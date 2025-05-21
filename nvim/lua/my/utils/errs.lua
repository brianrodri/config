local Fmts = require("my.utils.fmts")

local Errs = {
  -- NOTE: TODO's definition is intentionally inconsistent so that tools don't consider it to be an _actual_ TODO.

  --- Terminates the last protected call with a helpful "not implemented" error.
  ---
  ---@param func_name string  The name of the unimplemented function.
  ---@param ... any           The arguments passed to the function.
  ---@return unknown ...      Although this function never returns, the annotation convinces LuaLS that it does.
  TODO = function(func_name, ...) error(Fmts.call_error("not implemented", func_name, ...)) end,
}

return Errs
