local M = {}

---@param opts { desc: string, var_name: string, global?: boolean }
function M.var(opts)
  opts = opts or {}
  return require("snacks.toggle").new({
    id = opts.var_name,
    name = (opts.desc or opts.var_name) .. (opts.global and " (global)" or " (buffer)"),
    get = function() return M.get_var(opts.var_name, opts.global) end,
    set = function(state) M.set_var(opts.var_name, state, opts.global) end,
  }, opts)
end

---@overload fun(var: string, global?: boolean): state: boolean
function M.get_var(var, global)
  if vim.b[var] ~= nil and not global then
    return vim.b[var]
  elseif vim.g[var] ~= nil then
    return vim.g[var]
  else
    return true
  end
end

---@overload fun(var: string, global?: boolean, state: boolean)
function M.set_var(var, state, global)
  if global then
    vim.g[var] = state
    vim.b[var] = nil
  else
    vim.b[var] = state
  end
end

return M
