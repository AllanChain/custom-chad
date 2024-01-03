--[[======================================================
--            Configure builtin plugins
--======================================================]]
return {
  { "NvChad/nvterm", enabled = false },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        names = false,
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    ft = { "alpha" },
    dependencies = { "nvim-lua/plenary.nvim", "debugloop/telescope-undo.nvim" },
    opts = {
      extensions_list = { "themes", "projects", "undo" },
      defaults = {
        mappings = {
          i = {
            ["<C-Up>"] = function(bufnr)
              require("telescope.actions").cycle_history_prev(bufnr)
            end,
            ["<C-Down>"] = function(bufnr)
              require("telescope.actions").cycle_history_next(bufnr)
            end,
          },
        },
      },
    },
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local has_alpha, alpha = pcall(require, "alpha")
      if not has_alpha then
        return
      end
      alpha.setup(require("custom.configs.alpha").config)
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "luacheck",
        "typescript-language-server",
        "emmet-ls",
        "eslint_d",
        "pyright",
        "shfmt",
        "shellcheck",
      },
      github = {
        download_url_template = "https://mirror.ghproxy.com/github.com/%s/releases/download/%s/%s",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    -- Overriding whole config function to enable mirror.ghproxy
    config = function(_, opts)
      -- copied from NvChad config
      dofile(vim.g.base46_cache .. "syntax")
      require("nvim-treesitter.configs").setup(opts)

      -- change install url of parsers to mirror.ghproxy
      ---@diagnostic disable-next-line:redefined-local
      local ok, parsers = pcall(require, "nvim-treesitter.parsers")
      if not ok then
        return
      end
      for _, parser in pairs(parsers.list) do
        parser.install_info.url = parser.install_info.url:gsub("github", "mirror.ghproxy.com/github")
      end

      ---@diagnostic disable-next-line:redefined-local
      local ok, treesitter = pcall(require, "nvim-treesitter.configs")
      if not ok then
        return
      end
      ---@diagnostic disable-next-line:missing-fields
      treesitter.setup {
        ensure_installed = {
          "lua",
          "vim",
          "python",
          "javascript",
          "css",
          "html",
          "bash",
          "markdown",
          "markdown_inline",
          "regex",
        },
        highlight = {
          enable = true,
          use_languagetree = true,
        },
        -- use yati indent instead of the original one
        yati = {
          enable = true,
        },
        indent = {
          enable = false,
        },
        matchup = {
          enable = true,
        },
      }
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      git = {
        enable = true,
        ignore = true,
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    config = function(_, opts)
      local cmp = require "cmp"
      cmp.setup(opts)
      cmp.setup.filetype({ "julia", "latex" }, {
        sources = {
          {
            name = "latex_symbols",
            option = {
              strategy = 0, -- mixed
            },
          },
        },
      })
    end,
    dependencies = {
      { "kdheepak/cmp-latex-symbols" }, -- add unicode math completion
      {
        "windwp/nvim-autopairs",
        init = function() end,
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          local autopairs = require "nvim-autopairs"
          local cond = require "nvim-autopairs.conds"
          local handlers = require "nvim-autopairs.completion.handlers"
          autopairs.get_rules("'")[1]:with_pair(cond.not_filetypes { "scheme", "lisp", "clojure" })
          -- setup cmp for autopairs. Copied from NvChad
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          local cmp = require "cmp"
          cmp.event:on(
            "confirm_done",
            cmp_autopairs.on_confirm_done {
              filetypes = {
                tex = false,
              },
            }
          )
        end,
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPost",
    config = function()
      require "custom.configs.null-ls"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local ok, neodev = pcall(require, "neodev")
      -- Neodev should be set up before lspconfig
      if ok then
        neodev.setup {
          setup_jsonls = false,
        }
      end
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      filetype_exclude = {
        "help",
        "terminal",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "nvdash",
        "nvcheatsheet",
        "alpha",
        "notify",
        "",
      },
    },
  },
}
