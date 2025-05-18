local Fmts = require("my.utils.fmts")

local Dates = {}

--- Wrapper around |strftime()|.
---
---@param fmt string
---@param time? integer
function Dates.to_fmt(fmt, time)
  local ok, result = pcall(vim.fn.strftime, fmt, time)
  assert(ok, Fmts.call_error(result, "parse_date", fmt, time))
  return result
end

--- Wrapper around |strptime()|.
---
---@param fmt string
---@param time_str string
function Dates.from_fmt(fmt, time_str)
  local ok, result = pcall(vim.fn.strptime, fmt, time_str)
  assert(ok, Fmts.call_error(result, "parse_date", fmt, time_str))
  assert(result ~= 0, Fmts.call_error("could not be parsed", "parse_date", fmt, time_str))
  return result
end

return Dates
