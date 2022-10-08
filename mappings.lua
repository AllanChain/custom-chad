local M = {}
-- map("n", "<leader>fm", ":lua vim.lsp.buf.formatting()<CR>")
-- map('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })

M.user = {
	i = {
		["jk"] = { "<ESC>", "escape insert mode", opts = { nowait = true } },
	},
  n = {
    ["<leader>rf"] = { ":w<CR>:RunFile<CR>", "run file", opts = { noremap = true, silent = false } },
    ["<leader>qq"] = { ":q<CR>", "close window" },
    ["<leader>qa"] = { ":qa<CR>", "close all" },
  }
}

return M
