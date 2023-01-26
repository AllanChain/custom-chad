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
    ["<leader>gg"] = {
      function()
        local term = require("nvterm.terminal").new("float")
        vim.api.nvim_chan_send(term.job_id, "lazygit\n")
      end,
      "open Lazygit",
    },
    ["<leader>do"] = {
      vim.diagnostic.open_float,
      "open diagnostic",
      opts = { noremap = true, silent = true },
    },
    ["<leader>dd"] = {
      vim.diagnostic.disable,
      "disable diagnostic",
      opts = { noremap = true, silent = true },
    },
    ["<leader>de"] = {
      vim.diagnostic.enable,
      "enable diagnostic",
      opts = { noremap = true, silent = true },
    },
    ["<leader>fd"] = {
      function()
        require("telescope.builtin").diagnostics()
      end,
      "find diagnostic",
      opts = { noremap = true, silent = true },
    },
    ["<leader>fg"] = {
      function()
        require("telescope.builtin").git_commits()
      end,
      "find diagnostic",
      opts = { noremap = true, silent = true },
    },
  },
}

return M
