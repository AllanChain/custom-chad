local mappings = require "core.mappings"

local M = {
  disabled = mappings.nvterm
}

-- M.disabled = vim.tbl_deep_extend("force", M.disabled, mappings.nvterm)

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

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
    width = function (term)
      return vim.o.columns - 4
    end,
    height = function (term)
      return vim.o.lines - 5
    end,
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

M.term = {
  n = {
    ["<leader>gg"] = {
      function()
        lazygit:toggle()
      end,
      "open Lazygit",
    },
  }
}

return M
