local M = {}

M.user = {
  i = {
    ["jk"] = { "<ESC>", "escape insert mode", opts = { nowait = true } },
  },
  n = {
    ["<leader>rf"] = {
      ":w<CR>:RunFile<CR>",
      "run file",
      opts = { noremap = true, silent = false },
    },
    ["<leader>qq"] = { ":q<CR>", "close window" },
    ["<leader>qa"] = { ":qa<CR>", "close all" },
    ["<leader>sr"] = {
      function()
        require("ssr").open()
      end,
      "structural replace",
    },
    ["<leader>do"] = {
      function()
        vim.diagnostic.open_float()
      end,
      "open diagnostic",
      opts = { noremap = true, silent = true },
    },
    ["<leader>dd"] = {
      function()
        vim.diagnostic.disable()
      end,
      "disable diagnostic",
      opts = { noremap = true, silent = true },
    },
    ["<leader>de"] = {
      function()
        vim.diagnostic.enable()
      end,
      "enable diagnostic",
      opts = { noremap = true, silent = true },
    },
  },
}
return M
