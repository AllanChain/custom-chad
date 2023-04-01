local ok, null_ls = pcall(require, "null-ls")

if not ok then
  return
end

local utils = require "null-ls.utils"

local julia = require "custom.configs.null-ls.julia"

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
    if cond_cache[root] == nil then
      cond_cache[root] = {}
    end
    if cond_cache[root][name] ~= nil then
      return cond_cache[root][name]
    end
    local enabled = match_pattern(root, pattern)
    cond_cache[root][name] = enabled
    return enabled
  end
end

local sources = {
  --[[#########################
  --           Python
  --#########################]]
  b.formatting.isort.with {
    runtime_condition = create_run_condition("isort", {
      ".isort.cfg",
      { read = "pyproject.toml", find = "%[tool.isort%]" },
    }),
  },
  b.formatting.black,
  b.diagnostics.mypy.with {
    runtime_condition = create_run_condition("mypy", {
      ".mypy.ini",
      { read = "pyproject.toml", find = "%[tool.mypy%]" },
    }),
  },
  b.diagnostics.flake8.with {
    runtime_condition = create_run_condition("flake8", ".flake8"),
  },
  b.diagnostics.pydocstyle.with {
    runtime_condition = create_run_condition("pydocstyle", {
      ".pydocstyle",
      { read = "pyproject.toml", find = "%[tool.pydocstyle%]" },
    }),
  },
  b.diagnostics.ruff.with {
    runtime_condition = create_run_condition("ruff", {
      { read = "pyproject.toml", find = "%[tool.ruff%]" },
    }),
  },
  --[[#########################
  --     JS, HTML, and CSS
  --#########################]]
  b.formatting.prettier.with {
    prefer_local = "node_modules/.bin",
    runtime_condition = create_run_condition("prettier", ".prettierrc"),
  },
  b.formatting.eslint_d.with {
    runtime_condition = create_run_condition("eslint", ".eslintrc"),
  },
  b.diagnostics.eslint_d.with {
    runtime_condition = create_run_condition("eslint", ".eslintrc"),
  },
  b.code_actions.eslint_d.with {
    runtime_condition = create_run_condition("eslint", ".eslintrc"),
  },
  b.formatting.rome.with {
    prefer_local = "node_modules/.bin",
    runtime_condition = create_run_condition("rome", "rome.json"),
  },
  --[[#########################
  --            Lua
  --#########################]]
  b.formatting.stylua,
  b.diagnostics.luacheck.with { extra_args = { "--global vim" } },
  --[[#########################
  --       Miscellaneous
  --#########################]]
  b.formatting.shfmt,
  b.diagnostics.shellcheck,
  julia,
}

null_ls.setup {
  -- debug = true,
  sources = sources,
}
