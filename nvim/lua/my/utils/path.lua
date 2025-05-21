local Fmts = require("my.utils.fmts")

---@class my.Path
---@field path string
local Path = {}

Path.__index = Path
Path.__tostring = function(self) return self.path end
Path.__eq = function(self, obj) return Path.is_path_obj(self) and Path.is_path_obj(obj) and self.path == obj.path end

---@param obj any
---@return boolean is_path_obj
function Path.is_path_obj(obj) return getmetatable(obj) == Path end

--- Constructs a new `my.Path`. Wrapper around |vim.fs.joinpath()|.
---
---@param base my.Path|string   An absolute or relative path.
---@param ... my.Path|string|?  Zero or more relative paths. `nil`s are skipped.
---@return my.Path new_path
function Path.new(base, ...)
  assert(type(base) == "string" or Path.is_path_obj(base), Fmts.call_error("base not a path", "Path.new", base, ...))
  if type(base) ~= "string" and select("#", ...) == 0 then return base end
  local self = setmetatable({}, Path)
  self.path = vim.iter({ ... }):map(tostring):fold(tostring(base), vim.fs.joinpath)
  return self
end

--- Wrapper around |nvim_buf_get_name|.
---
---@param buffer_id? integer  Use 0 for current buffer (defaults to 0).
---@return my.Path buffer_path
function Path.of_buffer(buffer_id) return Path.new(vim.api.nvim_buf_get_name(buffer_id or 0)) end

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
---@overload fun(what: "cache" | "config" | "data" | "log" | "run" | "state"): stdpath: my.Path
---@overload fun(what: "config_dirs" | "data_dirs"): stdpaths: my.Path[]
function Path.stdpath(what)
  local result = vim.fn.stdpath(what)
  return type(result) == "table" and vim.tbl_map(Path.new, result) or Path.new(result)
end

--- Wrapper around |vim.fs.basename()|.
---
---@return string basename
function Path:basename() return vim.fs.basename(self.path) end

--- Returns |vim.fs.basename()| without an extension.
---
---@return string|? stem
function Path:stem()
  local basename = self:basename()
  return basename and string.match(basename, "^(.+)%.[^%.]+$") or basename
end

--- Wrapper around |vim.fs.dirname()|.
---
---@return my.Path|? dirname
function Path:dirname() return Path.new(vim.fs.dirname(self.path)) end

--- Wrapper around |vim.fs.normalize()|.
---
---@param opts? vim.fs.normalize.Opts
---@return my.Path normalized_path
function Path:normalize(opts) return Path.new(vim.fs.normalize(self.path, opts)) end

--- Wrapper around |fs_stat()|.
---
---@return boolean exists
function Path:exists() return vim.uv.fs_stat(self.path) ~= nil end

--- Wrapper around |fs_realpath()|.
---
---@return my.Path resolved_path
function Path:resolve()
  local realpath, err = vim.uv.fs_realpath(self.path)
  if not realpath then error(Fmts.call_error(err, "fs_realpath", self.path), 0) end
  return Path.new(realpath)
end

--- Wrapper around |io.open()| that ensures |file:close()| is always called.
---
---@generic T
---@param mode openmode
---@param callback fun(path: file*): ...: T this MUST NOT close the file.
---@return T ...
function Path:with_file(mode, callback)
  local file, open_err = io.open(self.path, mode)
  assert(file, Fmts.call_error(open_err, "io.open", self.path, mode))
  local pcall_results = table.pack(pcall(callback, file))
  local close_ok, close_err, close_err_code = file:close()
  local merged_err = Fmts.merge_lines({
    not close_ok and Fmts.call_error(Fmts.err_code(close_err, close_err_code), "file.close", file),
    not pcall_results[1] and Fmts.call_error(pcall_results[2], "callback", file),
  })
  assert(not merged_err, merged_err)
  return unpack(pcall_results, 2)
end

--- Wrapper around |isdirectory()|.
---
---@return boolean is_directory
function Path:is_directory() return vim.fn.isdirectory(self.path) == 1 end

--- Wrapper around |mkdir()|.
---
---@return boolean success
function Path:make_directory() return vim.fn.mkdir(self.path, "p") == 1 end

--- Wrapper around |vim.fs.root()|.
---
---@param marker
---| string                             A marker to search for.
---| string[]                           A list of markers to search for.
---| fun(path: my.Path): boolean  A function that returns true if matched.
---@return my.Path|? root_path
function Path:find_root(marker)
  local marker_wrapper = vim.is_callable(marker) and function(_, path) return marker(Path.new(path)) end or marker
  local root = vim.fs.root(self.path, marker_wrapper)
  return root and Path.new(root) or nil
end

return Path
