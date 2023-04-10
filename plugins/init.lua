return {
  --[[======================================================
                Configure builtin plugins
  ========================================================]]
  { "NvChad/nvterm", enabled = false },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = {
        "css",
        "javascript",
        "html",
        "vue",
        "svelte",
        "astro",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    ft = { "alpha" },
    opts = {
      extensions_list = { "themes", "projects" },
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
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "vue-language-server",
        "svelte-language-server",
        "astro-language-server",
        "emmet-ls",
        "json-lsp",
        "eslint_d",
        "pyright",
        "black",
        "mypy",
        "flake8",
        "pydocstyle",
        "julia-lsp",
        "shfmt",
        "shellcheck",
      },
      github = {
        download_url_template = "https://ghproxy.com/github.com/%s/releases/download/%s/%s",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    -- Overriding whole config function to enable ghproxy
    config = function(_, opts)
      -- copied from NvChad config
      dofile(vim.g.base46_cache .. "syntax")
      require("nvim-treesitter.configs").setup(opts)

      -- change install url of parsers to ghproxy
      ---@diagnostic disable-next-line:redefined-local
      local ok, parsers = pcall(require, "nvim-treesitter.parsers")
      if not ok then
        return
      end
      for _, parser in pairs(parsers.list) do
        parser.install_info.url = parser.install_info.url:gsub("github", "ghproxy.com/github")
      end

      ---@diagnostic disable-next-line:redefined-local
      local ok, treesitter = pcall(require, "nvim-treesitter.configs")
      if not ok then
        return
      end
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
    opts = require "custom.configs.cmp",
    dependencies = {
      { "kdheepak/cmp-latex-symbols" }, -- add unicode math completion
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
        "noice",
        "",
      },
    },
  },
  --[[======================================================
                      My custom plugins
  ========================================================]]
  { -- auto adjust shiftwidth
    "tpope/vim-sleuth",
    event = "BufReadPost",
  },
  { -- easy change surroundings
    "tpope/vim-surround",
    event = "BufReadPost",
  },
  {
    "ojroques/nvim-osc52", -- yank contents over SSH
    event = "BufReadPost",
    config = function()
      local ok, osc52 = pcall(require, "osc52")
      if not ok then
        return
      end
      osc52.setup {
        silent = true,
      }
    end,
  },
  {
    "yioneko/nvim-yati", -- better indent than treesitter
    event = "BufReadPost",
    requires = "nvim-treesitter/nvim-treesitter",
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    setup = function()
      vim.g.matchup_matchparen_enabled = false
    end,
  },
  {
    "ethanholz/nvim-lastplace", -- remember cursor positions
    event = "BufReadPost",
    config = function()
      local ok, lastplace = pcall(require, "nvim-lastplace")
      if not ok then
        return
      end
      lastplace.setup {}
    end,
  },
  {
    "folke/todo-comments.nvim", -- NOTE: fancy TODO comment
    event = "BufReadPost",
    config = function()
      local ok, comments = pcall(require, "todo-comments")
      if not ok then
        return
      end
      comments.setup {}
    end,
  },
  {
    "ggandor/leap.nvim", -- s{char1}{char2} fast navigation
    event = "BufReadPost",
    config = function()
      local ok, leap = pcall(require, "leap")
      if not ok then
        return
      end
      leap.add_default_mappings(true)
    end,
  },
  {
    "JuliaEditorSupport/julia-vim",
    lazy = false,
    ft = { "julia" },
  },
  {
    "ahmedkhalf/project.nvim", -- auto cd into project root
    lazy = false,
    config = function()
      local ok, project = pcall(require, "project_nvim")
      if not ok then
        return
      end
      project.setup {
        detection_methods = { "pattern", "lsp" },
        silent_chdir = false,
      }
      local p = require "project_nvim.project"
      local history = require "project_nvim.utils.history"
      -- ensure current dir is added to the session
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local root, _ = p.get_project_root()
          table.insert(history.session_projects, root)
        end,
      })
    end,
  },
  {
    "zoriya/auto-save.nvim", -- auto save
    -- using the fork until https://github.com/Pocco81/auto-save.nvim/pull/67
    event = "BufReadPost",
    config = function()
      local ok, autosave = pcall(require, "auto-save")
      if not ok then
        return
      end
      local utils = require "auto-save.utils.data"
      autosave.setup {
        print_enabled = false,
        callbacks = {
          after_saving = function()
            local msg = "Saved at " .. vim.fn.strftime "%H:%M:%S"
            vim.notify(msg, "info", {
              timeout = 100,
              title = "AutoSave",
              render = "compact",
            })
          end,
        },
        condition = function(buf)
          if vim.fn.getcwd():match "nvim/lua/custom" then
            return false
          end
          if
            vim.fn.getbufvar(buf, "&modifiable") == 1
            and utils.not_in(vim.fn.getbufvar(buf, "&filetype"), { "TelescopePrompt", "alpha" })
          then
            return true
          end
          return false
        end,
      }
    end,
  },
  { -- structural search and replace
    "cshuaimin/ssr.nvim",
    event = "BufReadPost",
  },
  { -- Wakatime integration
    "wakatime/vim-wakatime",
    event = "VimEnter",
  },
  { -- Neovim config intellisense. See lspconfig setup
    "folke/neodev.nvim",
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VimEnter",
    config = function()
      local ok, toggleterm = pcall(require, "toggleterm")
      if not ok then
        return
      end
      toggleterm.setup {
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = false,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
        },
      }
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    event = "BufReadPost",
    config = function()
      local ok, gc = pcall(require, "git-conflict")
      if not ok then
        return
      end
      gc.setup {
        default_mappings = false,
        disable_diagnostics = true,
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    event = "BufReadPost",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          local ui_ok, dapui = pcall(require, "dapui")
          local dap_ok, dap = pcall(require, "dap")
          if not ui_ok and dap_ok then
            return
          end
          vim.fn.sign_define("DapBreakpoint", {
            text = "",
            texthl = "DiagnosticSignError",
            linehl = "",
            numhl = "",
          })
          dapui.setup {}
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        end,
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          local ok, dap_text = pcall(require, "nvim-dap-virtual-text")
          if not ok then
            return
          end
          dap_text.setup {}
        end,
      },
      {
        "mfussenegger/nvim-dap-python",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
          local ok, dap_python = pcall(require, "dap-python")
          if not ok then
            return
          end
          dap_python.setup()
        end,
      },
    },
  },
  { -- Dim unused vars
    "zbirenbaum/neodim",
    event = "LspAttach",
    opts = {
      alpha = 0.5,
      blend_color = "#2e3440",
    },
    config = function(_, opts)
      require("neodim").setup(opts)
    end,
  },
  {
    "h-hg/fcitx.nvim",
    event = "BufReadPost",
  },
  { -- global search and replace
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
  },
  {
    "folke/noice.nvim",
    lazy = false,
    opts = {
      lsp = {
        signature = { enabled = false },
        hover = { enabled = false },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)
    end,
    dependencies = {
      {
        "MunifTanjim/nui.nvim",
      },
      {
        "rcarriga/nvim-notify",
      },
    },
  },
}
