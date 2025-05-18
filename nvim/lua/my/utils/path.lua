local Errs = require("my.utils.errs")
local Fmt = require("my.utils.fmt")

---@class my.Path
---@field path string
---@field resolved boolean
local Path = {
  -- NOTE: Returning `path` directly so that `tostring(Path)` is interchangeable with `tostring(path_string)`.
  __tostring = function(self) return self.path end,

  ---@private
  ---@type table<string, uv.fs_stat.result>
  global_status_cache = {},
}

---@param obj any
---@return boolean is_path_obj  True if and only if `obj` is an instance of `Path`.
function Path.is_path_obj(obj)
  if getmetatable(obj) ~= Path then return false end
  ---@cast obj my.Path
  return true
end

--- Wrapper around |vim.fs.joinpath()|. Terminates with an error if no paths are provided.
---
--- NOTE: This function is the "constructor" of this class!
---
---@param ... my.Path|string|?  The paths to join. The first must absolute or relative, the rest must be relative.
---@return my.Path joined_path  The concatenated path.
function Path.join(...)
  local path_parts = vim.iter({ ... }):filter(function(p) return p ~= nil end):totable()
  if #path_parts == 1 and Path.is_path_obj(path_parts[1]) then return path_parts[1] end
  assert(#path_parts > 0, Fmt.call_error("one or more path(s) required", "Path.join", ...))
  local ok, result = pcall(vim.fs.joinpath, unpack(vim.tbl_map(tostring, path_parts)))
  assert(ok, Fmt.call_error(result, "Path.join", ...))
  local self = setmetatable({}, Path)
  self.path = result
  self.resolved = false
  return self
end

--- Wrapper around |nvim_buf_get_name|.
---
---@param buffer_id? integer  Use 0 for current buffer (defaults to 0).
function Path.of_buffer(buffer_id)
  local ok, result = pcall(vim.api.nvim_buf_get_name, buffer_id or 0)
  assert(ok, Fmt.call_error(result, "Path.of_buffer", buffer_id))
  return Path.join(result)
end

--- Wrapper around |stdpath|.
---
---@param what
---| "cache"        Cache directory: arbitrary temporary storage for plugins, etc.
---| "config"       User configuration directory. |init.vim| is stored here.
---| "config_dirs"  Other configuration directories.
---| "data"         User data directory.
---| "data_dirs"    Other data directories.
---| "log"          Logs directory (for use by plugins too).
---| "run"          Run directory: temporary, local storage for sockets, named pipes, etc.
---| "state"        Session state directory: storage for file drafts, swap, undo, |shada|.
---
---@overload fun(what: "cache" | "config" | "data" | "log" | "run" | "state"): my.Path
---@overload fun(what: "config_dirs" | "data_dirs"): my.Path[]
function Path.stdpath(what)
  local ok, result = pcall(vim.fn.stdpath, what)
  assert(ok, Fmt.call_error(result, "Path.stdpath", what))
  return type(result) == "table" and vim.iter(result):map(Path.join):totable() or Path.join(result)
end

--- Wrapper around |io.open()| to ensure that |file:close()| is always called.
---
---@param mode openmode
---@param file_consumer fun(path: file*)
function Path:with_file(mode, file_consumer)
  local file, open_err = io.open(self.path, mode)
  assert(file, Fmt.call_error(open_err, "Path.with_file", self, mode, file_consumer))
  local call_ok, call_err = pcall(file_consumer, file)
  local close_ok, close_err, close_err_code = file:close()
  local root_cause = Errs.join(call_err, close_err and string.format("%s(%d)", close_err, close_err_code))
  assert(call_ok and close_ok, Fmt.call_error(root_cause, "Path.with_file", self, mode, file_consumer))
end

--- Wrapper around |mkdir()|.
function Path:make_directory() return vim.fn.mkdir(self.path, "p") == 1 end

--- Wrapper around |fs_realpath()|.
---
--- NOTE: This mutates `self`!
---
---@param force_sys_call? boolean  Always make system calls when true, even if the path has already been resolved.
---@return my.Path
function Path:resolve(force_sys_call)
  if not self.resolved or force_sys_call then
    self.resolved = false
    local realpath, err = vim.uv.fs_realpath(self.path)
    assert(realpath, Fmt.call_error(err, "Path.resolve", self))
    self.path, self.resolved = realpath, true
  end
  return self
end

--- Wrapper around |fs_stat()|.
---
---@param force_sys_call? boolean  Always make system calls when true, even if the status has already been resolved.
---@return uv.fs_stat.result
function Path:status(force_sys_call)
  assert(self.resolved, Fmt.call_error("Path.resolve() needs to be called first", "Path.status", self))
  if not Path.global_status_cache[self.path] or force_sys_call then
    Path.global_status_cache[self.path] = nil
    local stat, err = vim.uv.fs_stat(self.path)
    assert(stat, Fmt.call_error(err, "Path.status", self))
    Path.global_status_cache[self.path] = stat
  end
  return Path.global_status_cache[self.path]
end

--- Wrapper around |isdirectory()|.
---
---@return boolean
function Path:is_directory() return vim.fn.isdirectory(self.path) == 1 end

--- Wrapper around |vim.fs.dirname()|.
---
---@return my.Path|?
function Path:parent()
  local dirname = vim.fs.dirname(self.path)
  return dirname and Path.join(dirname)
end

--- Wrapper around |vim.fs.root()|.
---
---@param marker
---| string                             A marker to search for.
---| string[]                           A list of markers to search for.
---| fun(path: my.Path): boolean  A function that returns true if matched.
---@return my.Path|?
function Path:find_root(marker)
  local resolved_marker = vim.is_callable(marker) and function(_, path) return marker(Path.join(path)) end or marker
  local root = vim.fs.root(self.path, resolved_marker)
  return root and Path.join(root)
end

return Path
