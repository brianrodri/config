local M = {}

local ISO_DATE_FORMATS = { "%Y", "%Y-%m", "%Y-%m-%d", "%G-W%V" }

-- 60s * 60m * 24h * 6d = 518400 seconds
local SIX_DAYS_IN_SECS = 518400

---@param format string
---@param timestring string
---@return integer|nil epoch, nil|string err
---@nodiscard
function M.try_parse(format, timestring)
  local ok, result = pcall(vim.fn.strptime, format, timestring)
  if not ok then
    return nil, string.format('vim.fn.strptime("%s", "%s") error: %s', format, timestring, result)
  elseif result == 0 then
    return nil, string.format('vim.fn.strptime("%s", "%s") error: invalid timestring', format, timestring)
  else
    return result, nil
  end
end

function M.try_parse_iso(iso_str)
  ---@type string[]
  local parse_errs = {}

  for _, format in ipairs(ISO_DATE_FORMATS) do
    local epoch, err = M.try_parse(format, iso_str)
    if epoch then return epoch, nil end
    table.insert(parse_errs, err)
  end

  local debug_info = vim.iter(parse_errs):map(function(err) return "\t" .. err end):join("\n")
  return nil, string.format('"%s" is not an iso string:%n%s', iso_str, debug_info)
end

---@param epoch? number
function M.iso_week(epoch)
  return vim.fn.strftime("%G-W%V", epoch)
end

---@param epoch? number
function M.iso_week_number(epoch)
  return tonumber(vim.fn.strftime("%V", epoch))
end

---@param epoch? number
function M.iso_date(epoch)
  return vim.fn.strftime("%Y-%m-%d", epoch)
end

---@param epoch? number
function M.pretty_date(epoch)
  return vim.fn.strftime("%a %B %e %Y", epoch)
end

---@param epoch? number
function M.pretty_week(epoch)
  return vim.iter({ epoch, epoch + SIX_DAYS_IN_SECS }):map(M.pretty_date):join(" - ")
end

return M
