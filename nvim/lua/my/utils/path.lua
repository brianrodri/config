local Errs = require("my.utils.errs")
local Fmts = require("my.utils.fmts")

---@class my.Path
---@field path string
local Path = {
  __tostring = function(self) return self.path end,
  __eq = function(self, other) return self.path == other.path end,
}

---@param obj any
---@return boolean is_path_obj
function Path.is_path_obj(obj) return getmetatable(obj) ~= Path end

--- Wrapper around |vim.fs.joinpath()|. Terminates with an error if no paths are provided.
---
--- NOTE: This function is the "constructor" of this class!
---
---@param ... my.Path|string|?  The paths to join. The first must absolute or relative, the rest must be relative.
---@return my.Path joined_path  The concatenated path.
function Path.join(...)
  local path_parts = vim.iter({ ... }):filter(function(p) return p ~= nil end):totable()
  if #path_parts == 1 and Path.is_path_obj(path_parts[1]) then return path_parts[1] end
  assert(#path_parts > 0, Fmts.call_error("one or more path(s) required", "Path.join", ...))
  local ok, result = pcall(vim.fs.joinpath, unpack(vim.tbl_map(tostring, path_parts)))
  assert(ok, Fmts.call_error(result, "Path.join", ...))
  local self = setmetatable({}, Path)
  self.path = result
  return self
end

--- Wrapper around |nvim_buf_get_name|.
---
---@param buffer_id? integer  Use 0 for current buffer (defaults to 0).
function Path.of_buffer(buffer_id)
  local ok, result = pcall(vim.api.nvim_buf_get_name, buffer_id or 0)
  assert(ok, Fmts.call_error(result, "Path.of_buffer", buffer_id))
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
  assert(ok, Fmts.call_error(result, "Path.stdpath", what))
  return type(result) == "table" and vim.iter(result):map(Path.join):totable() or Path.join(result)
end

--- Wrapper around |vim.fs.basename()|.
---
---@return string|? basename
function Path:basename() return vim.fs.basename(self.path) end

--- Returns the |vim.fs.basename()| without the extension (i.e. the text after and including the final ".").
---
---@return string|? stem
function Path:stem()
  local basename = self:basename()
  if not basename then return nil end
  local parts = vim.iter(vim.split(basename, "."))
  parts:pop()
  return parts:join(".")
end

--- Wrapper around |vim.fs.dirname()|.
---
---@return my.Path|? dirname
function Path:dirname()
  local dirname = vim.fs.dirname(self.path)
  return dirname and Path.join(dirname)
end

--- Wrapper around |vim.fs.normalize()|.
---
---@param opts? vim.fs.normalize.Opts
---@return my.Path normalized_path
function Path:normalize(opts) return Path.join(vim.fs.normalize(self.path, opts)) end

--- Wrapper around |uv.fs_stat()|.
---
---@return boolean exists
function Path:exists() return vim.uv.fs_stat(self.path) ~= nil end

--- Wrapper around |io.open()| to ensure that |file:close()| is always called.
---
---@param mode openmode
---@param file_consumer fun(path: file*)
function Path:with_file(mode, file_consumer)
  local file, open_err = io.open(self.path, mode)
  assert(file, Fmts.call_error(open_err, "Path.with_file", self, mode, file_consumer))
  local call_ok, call_err = pcall(file_consumer, file)
  local close_ok, close_err, close_err_code = file:close()
  local root_cause = Errs.join(call_err, close_err and string.format("%s(%d)", close_err, close_err_code))
  assert(call_ok and close_ok, Fmts.call_error(root_cause, "Path.with_file", self, mode, file_consumer))
end

--- Wrapper around |mkdir()|.
function Path:make_directory() return vim.fn.mkdir(self.path, "p") == 1 end

--- Wrapper around |fs_realpath()|.
---
--- NOTE: This mutates `self`!
---
---@return my.Path
function Path:resolve()
  local realpath, err = vim.uv.fs_realpath(self.path)
  assert(realpath, Fmts.call_error(err, "Path.resolve", self))
  self.path = realpath
  return self
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
  return dirname and Path.join(dirname) or nil
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
  return root and Path.join(root) or nil
end

return Path
