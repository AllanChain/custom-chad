vim.opt.relativenumber = true

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.utils").load_mappings()
  require("custom.bootstrap").lazy(lazypath)
end
