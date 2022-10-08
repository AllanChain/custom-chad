local M = {}

M.enabled = function()
  -- return vim.bo.filetype ~= "julia" or string.find(vim.api.nvim_get_current_line(), "\\%w+$") == nil
  if vim.bo.filetype == "julia" then
    return string.find(vim.api.nvim_get_current_line(), "\\") == nil
  end
  return true
end

return M
