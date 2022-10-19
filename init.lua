-- This is where your custom modules and plugins go.

local opt = vim.opt

opt.relativenumber = true

-- Restore cursor last position upon reopening the file
vim.cmd [[ 
  augroup last_cursor_position 
    autocmd! 
    autocmd BufReadPost * 
      \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' | execute "normal! g`\"zvzz" | endif 
  augroup END 
]]

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
