vim.opt.relativenumber = true

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.utils").load_mappings()
  require("custom.bootstrap").lazy(lazypath)
end

-- setup colorcolumn based on editorconfig
vim.api.nvim_create_autocmd("BufEnter", {
  pattern="*",
  callback=function ()
    local bufnr = vim.api.nvim_get_current_buf()
    local config = vim.b[bufnr].editorconfig
    if config == nil then return end
    local tw = config.max_line_length
    if tw == nil then return end
    vim.api.nvim_win_set_option(0, "colorcolumn", tw)
  end
})

-- better autoread on file change
-- https://github.com/neovim/neovim/issues/1936#issuecomment-309311829
vim.api.nvim_create_autocmd("FocusGained", {
  pattern = "*",
  callback = function ()
    vim.cmd("checktime") -- checktime triggers autoread
  end
})
