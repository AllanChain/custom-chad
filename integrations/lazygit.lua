local ok, terminal = pcall(require, "toggleterm.terminal")
if not ok then
  return nil
end

local Terminal = terminal.Terminal
return Terminal:new {
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
    width = function(_)
      return vim.o.columns - 4
    end,
    height = function(_)
      return vim.o.lines - 5
    end,
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd "startinsert!"
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
  -- function to run on closing the terminal
  on_close = function(_)
    vim.cmd "startinsert!"
  end,
}
