local ok, null_ls = pcall(require, "null-ls")

if not ok then
  return
end

local ok, julia = pcall(require, "custom.plugins.null-ls.julia")
if not ok then
  return
end

local b = null_ls.builtins

local sources = {
  b.formatting.isort,
  b.formatting.black,
  b.diagnostics.mypy,
  b.diagnostics.flake8,
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
