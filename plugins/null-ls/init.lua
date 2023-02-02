local ok, null_ls = pcall(require, "null-ls")

if not ok then
  return
end

local utils = require "null-ls.utils"

local julia = require "custom.plugins.null-ls.julia"

local b = null_ls.builtins

local cond_cache = {}

local function match_pattern(root, pattern)
  if type(pattern) == "function" then
    return pattern(root)
  elseif type(pattern) == "string" then
    return utils.make_conditional_utils().root_has_file_matches(pattern)
  elseif type(pattern) == "table" then
    if #pattern > 0 then -- pattern is an array
      for _, v in ipairs(pattern) do
        if match_pattern(root, v) then
          return true
        end
      end
      return false
    else
      if pattern.read == nil or pattern.find == nil then
        return false
      end
      local f = io.open(root .. "/" .. pattern.read, "r")
      if f == nil then
        return false
      end
      for line in f:lines() do
        if line:match(pattern.find) then
          return true
        end
      end
      return false
    end
  end
end
local function create_run_condition(name, pattern)
  return function(params)
    local root = params.root or utils.get_root()
    local bufnr = params.bufnr
    if cond_cache[bufnr] == nil then
      cond_cache[bufnr] = {}
    end
    if cond_cache[bufnr][name] ~= nil then
      return cond_cache[bufnr][name]
    end
    local enabled = match_pattern(root, pattern)
    cond_cache[bufnr][name] = enabled
    return enabled
  end
end

local sources = {
  b.formatting.isort.with { extra_args = { "--profile=black" } },
  b.formatting.black,
  b.diagnostics.mypy,
  b.diagnostics.flake8.with { extra_args = { "--max-line-length=88" } },
  b.diagnostics.pydocstyle.with {
    extra_args = { "--ignore=D1" },
    runtime_condition = create_run_condition("pydocstyle", {
      ".pydocstyle",
      { read = "pyproject.toml", find = "pydocstyle" },
    }),
  },
  b.formatting.shfmt,
  b.diagnostics.shellcheck,
  b.formatting.prettier.with {
    runtime_condition = create_run_condition("prettier", ".prettierrc"),
  },
  julia,
  -- JS html css stuff
  -- b.formatting.eslint.with {
  --    prefer_local = "node_modules/.bin",
  -- },
  -- b.diagnostics.eslint.with {
  --    prefer_local = "node_modules/.bin",
  -- },

  -- Lua
  b.formatting.stylua,
  b.diagnostics.luacheck.with { extra_args = { "--global vim" } },
}

null_ls.setup {
  sources = sources,
}
