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

---@generic Args, Return
---@param f fun(...: Args): Return
---@param ...? Args
---@return fun(...?: Args): Return
local function bind_left(f, ...)
  local left_args = { ... }
  return function(...) return f(unpack(left_args), ...) end
end

local bind = bind_left

---@generic Args, Return
---@param f fun(...: Args): Return
---@param ...? Args
---@return fun(...?: Args): Return
local function bind_right(f, ...)
  local right_args = { ... }
  return function(...) return f(..., unpack(right_args)) end
end

---@param s1 string
---@param s2 string
local function concat(s1, s2) return s1 .. s2 end

---@param str string
---@param prefix? string
---@param first_prefix? string
local function indent(str, prefix, first_prefix)
  prefix = prefix or "\t"
  return vim
    .iter(ipairs(vim.split(str, "\n")))
    :map(function(i, line) return concat(i == 1 and first_prefix or prefix, line) end)
    :join("\n")
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
  concat = concat,
  indent = indent,
  iso_date = iso_date,
  iso_week = iso_week,
  iso_week_number = iso_week_number,
  pretty_date = pretty_date,
  pretty_week = pretty_week,
  try_parse = try_parse,
}
