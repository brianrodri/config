local Fmts = {}

---@class fmts.IndentOpts
---@field line1_indent string  Prepended to the first line of each message. Uses `"- "` by default.
---@field lineN_indent string  Prepended to the subsequent lines of each message. Uses `"  "` by default.

---@class fmts.IndentUserOpts: fmts.IndentOpts
---@field line1_indent? string
---@field lineN_indent? string

---@param message string             A string with one or more lines.
---@param opts? fmts.IndentUserOpts  Indentation options.
function Fmts.indent(message, opts)
  local line1_indent = opts and opts.line1_indent or "- "
  local lineN_indent = opts and opts.lineN_indent or "  "
  return vim
    .iter(ipairs(vim.split(message, "\n")))
    :map(function(i, line) return (i == 1 and line1_indent or lineN_indent) .. line end)
    :join("\n")
end

--- Joins two or more formatted inputs with indents and newlines, otherwise returns `nil` or the formatted input alone.
---
---@param input any|any[]            A single value or an array of values. Skips `false` and `nil` values.
---@param opts? fmts.IndentUserOpts  Indentation options used for two or more input messages values.
---@return string|? merged
function Fmts.merge_lines(input, opts)
  if input and not vim.islist(input) then input = { input } end
  local messages = vim.iter(input or {}):map(function(i) return i and tostring(i) or nil end):totable()
  if #messages < 2 then return messages[1] end
  return vim.iter(messages):map(function(msg) return "\n" .. Fmts.indent(msg, opts) end):join("")
end

--- Provides consistent formatting for errors raised by invalid assignments.
---
---@param err unknown           The error.
---@param field string          The name of the field.
---@param value any             The bad value assigned to the field.
---@return string assign_error  A helpful error message with debug info about the assignment responsible.
function Fmts.assign_error(err, field, value)
  return string.format("%s=%s error: %s", field, vim.inspect(value), tostring(err))
end

--- Provides consistent formatting for errors raised by functions.
---
---@param err unknown         The error.
---@param func_name string    The name of the function.
---@param ... any             The arguments passed to the function.
---@return string call_error  A helpful error message with debug info about the call responsible.
function Fmts.call_error(err, func_name, ...)
  local formatted_args = vim.fn.join(vim.tbl_map(vim.inspect, { ... }), ", ")
  return string.format("%s(%s) error: %s", func_name, formatted_args, tostring(err))
end

--- Provides consistent formatting for implementing |__tostring| functions.
---
---@generic T: table
---@param obj T              The object to format.
---@param class_name string  The object's class name.
---@param ... string         The object fields included in the string.
---@return string obj_str    The object's string representation.
function Fmts.class_string(obj, class_name, ...)
  local format_field = function(field) return string.format("%s=%s", field, vim.inspect(obj[field])) end
  return string.format("%s{ %s }", class_name, vim.fn.join(vim.tbl_map(format_field, { ... }), ", "))
end

--- Provides consistent formatting for errors with an optional integer code.
---
---@param err? string
---@param err_code? integer
---@return string|? err_code_message
function Fmts.err_code(err, err_code)
  if err and err_code then return string.format("%s(%d)", err, err_code) end
  if err then return err end
  if err_code then return tostring(err_code) end
end

return Fmts
