local M = {}

M.sources = {
  { name = "luasnip" },
  { name = "nvim_lsp" },
  { name = "buffer" },
  { name = "nvim_lua" },
  { name = "path" },
  {
    name = "latex_symbols",
    option = {
      strategy = 0, -- mixed
    },
  },
}

return M
