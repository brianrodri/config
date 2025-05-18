local Fmts = {}

--- Provides consistent formatting for implementing |__tostring| functions.
---
---@generic T: table
---@param obj T              The object to format.
---@param class_name string  The object's class name.
---@param ... string         The object fields included in the string.
---@return string obj_str    The object's string representation.
function Fmts.class_string(obj, class_name, ...)
  local fields = vim.iter({ ... }):map(function(f) return string.format("%s=%s", f, vim.inspect(obj[f])) end):join(", ")
  return string.format("%s(%s)", class_name, fields)
end

--- Provides consistent formatting for errors raised by functions.
---
---@param err unknown         The error object.
---@param func_name string    The name of the function that caused the error.
---@param ... any             The arguments passed to the function.
---@return string call_error  A helpful error message with debug info about the call responsible.
function Fmts.call_error(err, func_name, ...)
  local debug_args = vim.fn.join(vim.tbl_map(vim.inspect, { ... }), ", ")
  return string.format("%s(%s) error: %s", func_name, debug_args, tostring(err))
end

return Fmts
