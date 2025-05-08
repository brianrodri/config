local ONE_DAY_IN_SECS = 86400 -- 60s * 60m * 24h

---@param format string
---@param timestring string
---@return integer|nil epoch, nil|string err
---@nodiscard
local function try_parse(format, timestring)
  local ok, result = pcall(vim.fn.strptime, format, timestring)
  if not ok then
    return nil, string.format('vim.fn.strptime("%s", "%s") error: %s', format, timestring, result)
  elseif result == 0 then
    return nil, string.format('vim.fn.strptime("%s", "%s") error: string not using format', format, timestring)
  else
    return result, nil
  end
end

---@generic ALL_ARGS, LEFT_ARGS
---@param f fun(...: ALL_ARGS)
---@param ... LEFT_ARGS
local function bind_left(f, ...)
  local bindings = { ... }
  ---@generic RIGHT_ARGS
  ---@param ... RIGHT_ARGS
  return function(...) return f(unpack(bindings), ...) end
end

---@generic ALL_ARGS, RIGHT_ARGS
---@param f fun(...: ALL_ARGS)
---@param ... RIGHT_ARGS
local function bind_right(f, ...)
  local bindings = { ... }
  ---@generic LEFT_ARGS
  ---@param ... LEFT_ARGS
  return function(...) return f(..., unpack(bindings)) end
end

local bind = bind_left

---@param s1 string
---@param s2 string
local function concat(s1, s2) return s1 .. s2 end

---@param str string
---@param prefix? string
---@param first_prefix? string
local function indent(str, prefix, first_prefix)
  prefix = prefix or "\t"
  first_prefix = first_prefix or prefix
  local lines = vim.split(str, "\n")
  local lines_with_prefixes = vim.list_extend(
    { concat(first_prefix, lines[1]) },
    vim.iter(vim.list_slice(lines, 2)):map(bind(concat, prefix)):totable()
  )
  return vim.iter(lines_with_prefixes):join("\n")
end

---@param epoch number
---@return string
---@nodiscard
local function iso_week(epoch) return tostring(os.date("%Y-W%V", epoch)) end

---@param epoch number
---@return number
---@nodiscard
local function iso_week_number(epoch) return tonumber(tostring(os.date("%V", epoch)), 10) end

---@param epoch number
---@return string
---@nodiscard
local function iso_date(epoch) return tostring(os.date("%Y-%m-%d", epoch)) end

---@param epoch number
---@return string
---@nodiscard
local function pretty_date(epoch) return tostring(os.date("%a %B %-d %Y", epoch)) end

---@param epoch number
---@return string
---@nodiscard
local function pretty_week(epoch)
  return vim.iter({ epoch, epoch + 6 * ONE_DAY_IN_SECS }):map(pretty_date):join(" - ")
end

return {
  bind = bind,
  bind_left = bind_left,
  bind_right = bind_right,
  try_parse = try_parse,
  concat = concat,
  indent = indent,
  iso_week = iso_week,
  iso_week_number = iso_week_number,
  iso_date = iso_date,
  pretty_date = pretty_date,
  pretty_week = pretty_week,
}
