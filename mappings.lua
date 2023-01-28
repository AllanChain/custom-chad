local mappings = require "core.mappings"

local M = {
  disabled = mappings.nvterm,
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
  },
}

M.diagnostics = {
  n = {
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
  },
}

M.telescope = {
  n = {
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
    ["<leader>fp"] = {
      function()
        require'telescope'.extensions.projects.projects{}
      end,
      "find projects",
      opts = { noremap = true, silent = true },
    },
  },
}

M.term = {
  n = {
    ["<leader>gg"] = {
      function()
        local lazygit = require "custom.integrations.lazygit"
        if lazygit then
          lazygit:toggle()
        end
      end,
      "open Lazygit",
      opts = { noremap = true, silent = true },
    },
  },
}

return M
