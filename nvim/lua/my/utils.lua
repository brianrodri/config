---@generic Arg, Ret
---@param func fun(...: Arg): Ret
---@param ...? Arg
---@return fun(...?: Arg): Ret
local function bind_left(func, ...)
  local left_args = { ... }
  return function(...) return func(unpack(left_args), ...) end
end

---@generic Arg, Ret
---@param func fun(...: Arg): Ret
---@param ...? Arg
---@return fun(...?: Arg): Ret
local function bind_right(func, ...)
  local right_args = { ... }
  return function(...) return func(..., unpack(right_args)) end
end

---@generic FArg, GArg, GRet
---@param f fun(...: FArg): ...: GArg
---@param g fun(...: GArg): ...: GRet
---@return fun(...: FArg): ...: GRet
local function compose(f, g)
  return function(...) return g(f(...)) end
end

---@overload fun(format_str: string, time: integer): time_str: string, err: nil
---@overload fun(format_str: string, time: integer): time_str: nil, err: string
local function try_format(format_str, time)
  local ok, result = pcall(vim.fn.strftime, format_str, time)
  if not ok then return nil, string.format('format("%s", %d) error: %s', format_str, time, result) end
  if not result then return nil, string.format('format("%s", %d) error: bad format', format_str, time) end
  return tostring(result), nil
end

---@overload fun(format_str: string, time_str: string): time: integer, err: nil
---@overload fun(format_str: string, time_str: string): time: nil, err: string
local function try_parse(format_str, time_str)
  local ok, result = pcall(vim.fn.strptime, format_str, time_str)
  if not ok then return nil, string.format('parse("%s", "%s") error: %s', format_str, time_str, result) end
  if result == 0 then return nil, string.format('parse("%s", "%s") error: bad format', format_str, time_str) end
  return result, nil
end

---@overload fun(var: string, global?: boolean): state: boolean
local function get_var(var, global)
  if vim.b[var] ~= nil and not global then
    return vim.b[var]
  elseif vim.g[var] ~= nil then
    return vim.g[var]
  else
    return true
  end
end

---@overload fun(var: string, global?: boolean, state: boolean)
local function set_var(var, state, global)
  if global then
    vim.g[var] = state
    vim.b[var] = nil
  else
    vim.b[var] = state
  end
end

---@overload fun(opts: { desc: string, var_name: string, global?: boolean }): snacks.toggle.Class
local function var_toggle(opts)
  opts = opts or {}
  return require("snacks.toggle").new({
    id = opts.var_name,
    name = (opts.desc or opts.var_name) .. (opts.global and " (global)" or " (buffer)"),
    get = function() return get_var(opts.var_name, opts.global) end,
    set = function(state) set_var(opts.var_name, state, opts.global) end,
  }, opts)
end

---@generic T
---@param items T|T[]
---@return T[]
local function dedupe(items)
  local result = {}
  local seen = {}
  for _, v in ipairs(type(items) == "table" and items or { items }) do
    if not seen[v] then
      seen[v] = true
      table.insert(result, v)
    end
  end
  return result
end

return {
  bind_left = bind_left,
  bind_right = bind_right,
  compose = compose,
  dedupe = dedupe,
  try_format = try_format,
  try_parse = try_parse,
  get_var = get_var,
  set_var = set_var,
  var_toggle = var_toggle,
}
