return {
  --[[======================================================
                Configure builtin plugins
  ========================================================]]
  ["folke/which-key.nvim"] = {
    disable = false,
    module = "which-key",
    keys = { "<leader>", '"', "'", "`", "g" },
  },
  ["wbthomason/packer.nvim"] = {
    override_options = {
      git = {
        default_url_format = "https://ghproxy.com/github.com/%s.git",
      },
    },
  },
  ["NvChad/nvterm"] = false,
  ["nvim-telescope/telescope.nvim"] = {
    ft = { "alpha" },
    override_options = {
      extensions_list = { "themes", "projects" },
    },
  },
  ["goolord/alpha-nvim"] = {
    disable = false,
    config = function()
      local has_alpha, alpha = pcall(require, "alpha")
      if not has_alpha then
        return
      end
      alpha.setup(require("custom.plugins.alpha").config)
    end,
  },
  ["williamboman/mason.nvim"] = {
    override_options = {
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
  ["nvim-treesitter/nvim-treesitter"] = {
    -- Overriding whole config function to enable ghproxy
    config = function()
      -- copied from NvChad config
      local ok, base46 = pcall(require, "base46")
      if not ok then
        return
      end
      base46.load_highlight "treesitter"

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
          "help",
          "python",
          "javascript",
          "css",
          "html",
          "bash",
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
  ["nvim-tree/nvim-tree.lua"] = {
    override_options = {
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
  ["hrsh7th/nvim-cmp"] = {
    override_options = require "custom.plugins.cmp",
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  --[[======================================================
                      My custom plugins
  ========================================================]]
  ["tpope/vim-sleuth"] = {}, -- auto adjust shiftwidth
  ["tpope/vim-surround"] = {}, -- easy change surroundings
  ["yioneko/nvim-yati"] = { -- better indent than treesitter
    event = "BufReadPost",
    requires = "nvim-treesitter/nvim-treesitter",
  },
  ["andymass/vim-matchup"] = {
    event = "BufReadPost",
    setup = function()
      vim.g.matchup_matchparen_enabled = false
    end,
  },
  ["ethanholz/nvim-lastplace"] = { -- remember cursor positions
    config = function()
      local ok, lastplace = pcall(require, "nvim-lastplace")
      if not ok then
        return
      end
      lastplace.setup {}
    end,
  },
  ["folke/todo-comments.nvim"] = { -- NOTE: fancy TODO comment
    config = function()
      local ok, comments = pcall(require, "todo-comments")
      if not ok then
        return
      end
      comments.setup {}
    end,
  },
  ["ggandor/leap.nvim"] = { -- s{char1}{char2} fast navigation
    config = function()
      local ok, leap = pcall(require, "leap")
      if not ok then
        return
      end
      leap.add_default_mappings(true)
    end,
  },
  ["JuliaEditorSupport/julia-vim"] = {},
  ["ahmedkhalf/project.nvim"] = { -- auto cd into project root
    config = function()
      local ok, project = pcall(require, "project_nvim")
      if not ok then
        return
      end
      project.setup {
        detection_methods = { "pattern", "lsp" },
        silent_chdir = false,
      }
    end,
  },
  ["Pocco81/auto-save.nvim"] = { -- auto save
    config = function()
      local ok, autosave = pcall(require, "auto-save")
      if not ok then
        return
      end
      local utils = require "auto-save.utils.data"
      autosave.setup {
        condition = function(buf)
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
  ["cshuaimin/ssr.nvim"] = {}, -- structural search and replace
  ["kdheepak/cmp-latex-symbols"] = { -- add unicode math completion
    after = "nvim-cmp",
  },
  ["wakatime/vim-wakatime"] = { -- Wakatime integration
    after = "nvim-lspconfig",
  },
  ["akinsho/toggleterm.nvim"] = {
    tag = "*",
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
  ["akinsho/git-conflict.nvim"] = {
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
}
-- return {
--    {
--       "NoahTheDuke/vim-just",
--       after = "nvim-lspconfig",
--    },
--    {
--       "IndianBoy42/tree-sitter-just",
--       ft = { "just" },
--       after = "nvim-lspconfig",
--       -- config = function()
--       --    require("tree-sitter-just").setup()
--       -- end,
--    },
-- }
