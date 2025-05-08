---@generic Args, Return
---@param f fun(...: Args): ...: Return
---@param ...? Args
---@return fun(...?: Args): ...: Return
---Returns a new function with pre-defined leading arguments.
local function bind_left(f, ...)
  local left_args = { ... }
  return function(...) return f(unpack(left_args), ...) end
end

---@generic Args, Return
---@param f fun(...: Args): Return
---@param ...? Args
---@return fun(...?: Args): Return
---Returns a new function with pre-defined trailing arguments.
local function bind_right(f, ...)
  local right_args = { ... }
  return function(...) return f(..., unpack(right_args)) end
end

---@generic Args, Return
---@param f fun(...: Args)
---@param g fun(...): Return
---@return fun(...: Args): ...: Return
---Returns a new function that calls g with the result of calling f.
local function compose(f, g)
  return function(...) return g(f(...)) end
end

---@generic T
---@param ... T
---@return T ...
local function identity(...) return ... end

---@nodiscard
---@overload fun(format: string, time: integer): string, nil
---@overload fun(format: string, time: integer): nil, string
---Attempts to return the time with the given format encoding, otherwise nil and an error.
local function try_format(format, time)
  local ok, result = pcall(os.date, format, time)
  if not ok then return nil, string.format('os.date("%s", %s) error: %s', format, time, result) end
  return tostring(result), nil
end

---@nodiscard
---@overload fun(format: string, time_str: string): integer, nil
---@overload fun(format: string, time_str: string): nil, string
---Attempts to parse an epoch time (as per os.date()) from the timestring using the provided format.
---If successful, returns the epoch time. Otherwise, returns nil and an error describing the issue.
local function try_parse(format, time_str)
  local ok, result = pcall(vim.fn.strptime, format, time_str)
  if not ok then return nil, string.format('strptime("%s", "%s") error: %s', format, time_str, result) end
  if result == 0 then return nil, string.format('strptime("%s", "%s") error: bad format', format, time_str) end
  return result, nil
end

return {
  bind_left = bind_left,
  bind_right = bind_right,
  compose = compose,
  identity = identity,
  try_format = try_format,
  try_parse = try_parse,
}
