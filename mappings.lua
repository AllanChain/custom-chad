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
    ["<Esc>"] = { ":noh <CR>", "clear highlights", opts = { silent = true } },
    ["<leader>qq"] = { ":q<CR>", "close window", opts = { silent = true } },
    ["<leader>qa"] = { ":qa<CR>", "close all", opts = { silent = true } },
    ["ZZ"] = { "<cmd>xa<cr>", "close and write", opt = { silent = true } },
    ["<leader>sr"] = {
      function()
        require("ssr").open()
      end,
      "structural replace",
    },
  },
}

M.bufferline = {
  n = {
    ["<tab>"] = {
      function()
        require("bufferline").cycle(1)
      end,
      "Goto next buffer",
    },

    ["<S-tab>"] = {
      function()
        require("bufferline").cycle(-1)
      end,
      "Goto prev buffer",
    },
    -- close buffer + hide terminal buffer
    ["<leader>x"] = {
      function()
        local bufferline = require "bufferline"
        local bufnr = vim.api.nvim_get_current_buf()
        bufferline.cycle(1)
        bufferline.unpin_and_close(bufnr)
      end,
      "Close buffer",
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

M.dap = {
  n = {
    ["<leader>dc"] = {
      function()
        require("dap").continue()
      end,
      "DAP continue",
      opts = { noremap = true, silent = true },
    },
    ["<leader>db"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "DAP breakpoint",
      opts = { noremap = true, silent = true },
    },
  },
}

M.telescope = {
  n = {
    ["<leader>fd"] = {
      "<cmd> Telescope diagnostics <CR>",
      "find diagnostic",
      opts = { noremap = true, silent = true },
    },
    ["<leader>fp"] = {
      "<cmd> Telescope projects <CR>",
      "find projects",
      opts = { noremap = true, silent = true },
    },
    ["<leader>fu"] = {
      "<cmd> Telescope undo <CR>",
      "undo history",
      opts = { noremap = true, silent = true },
    },
    ["<leader>fF"] = {
      function()
        require("telescope.builtin").find_files {
          no_ignore = true,
          hidden = true,
          file_ignore_patterns = {
            "node_modules/",
            "__pycache__/",
          },
        }
      end,
      "find files (no ignore)",
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
          lazygit.toggle()
        end
      end,
      "open Lazygit",
      opts = { noremap = true, silent = true },
    },
    ["<leader>rf"] = {
      function()
        local run = require "custom.integrations.run_file"
        if not run then
          return
        end
        run.run_file {
          filename = vim.fn.expand "%",
          num = 10,
          direction = "horizontal",
          size = 10,
        }
      end,
      "run file",
      opts = { noremap = true, silent = false },
    },
  },
}

M.git_conflict = {
  n = {
    ["<leader>co"] = { "<Plug>(git-conflict-ours)", "use ours", opts = { noremap = true, silent = true } },
    ["<leader>ct"] = { "<Plug>(git-conflict-theirs)", "use theirs", opts = { noremap = true, silent = true } },
    ["<leader>cb"] = { "<Plug>(git-conflict-both)", "use both", opts = { noremap = true, silent = true } },
    ["<leader>cn"] = { "<Plug>(git-conflict-none)", "use none", opts = { noremap = true, silent = true } },
    ["[x"] = { "<Plug>(git-conflict-prev-conflict)", "prev conflict", opts = { noremap = true, silent = true } },
    ["]x"] = { "<Plug>(git-conflict-next-conflict)", "next conflict", opts = { noremap = true, silent = true } },
  },
}

return M
