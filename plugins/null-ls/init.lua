local ok, null_ls = pcall(require, "null-ls")

if not ok then
  return
end

local julia = require("custom.plugins.null-ls.julia")

local b = null_ls.builtins

local sources = {
  b.formatting.isort.with { extra_args = { "--profile=black" }},
  b.formatting.black,
  b.diagnostics.mypy,
  b.diagnostics.flake8.with { extra_args = { "--max-line-length=88" }},
  b.diagnostics.pydocstyle.with { extra_args = { "--ignore=D1" } },
  b.formatting.shfmt,
  b.diagnostics.shellcheck,
  b.formatting.prettier,
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
