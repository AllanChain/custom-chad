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
      }
    },
  },
  ["nvim-treesitter/nvim-treesitter"] = {
    -- Overriding whole config function to enable ghproxy
    config = function()
      -- copied from NvChad config
      require("base46").load_highlight "treesitter"

      -- change install url of parsers to ghproxy
      local parsers = require "nvim-treesitter.parsers"
      for _, parser in pairs(parsers.list) do
        parser.install_info.url = parser.install_info.url:gsub("github", "ghproxy.com/github")
      end

      require("nvim-treesitter.configs").setup {
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
      }
    end,
  },
  ["kyazdani42/nvim-tree.lua"] = {
    override_options = {
      open_on_setup = true,
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
    requires = "nvim-treesitter/nvim-treesitter",
  },
  ["ethanholz/nvim-lastplace"] = { -- remember cursor positions
    config = function()
      require("nvim-lastplace").setup {}
    end,
  },
  ["folke/todo-comments.nvim"] = { -- NOTE: fancy TODO comment
    config = function()
      require("todo-comments").setup {}
    end,
  },
  ["ggandor/leap.nvim"] = { -- s{char1}{char2} fast navigation
    config = function()
      require("leap").add_default_mappings(true)
    end,
  },
  ["JuliaEditorSupport/julia-vim"] = {},
  ["ahmedkhalf/project.nvim"] = { -- auto cd into project root
    config = function()
      require("project_nvim").setup {}
    end,
  },
  ["Pocco81/auto-save.nvim"] = { -- auto save
    config = function()
      require("auto-save").setup {}
    end,
  },
  ["cshuaimin/ssr.nvim"] = {}, -- structural search and replace
  ["kdheepak/cmp-latex-symbols"] = { -- add unicode math completion
    after = "nvim-cmp",
  },
  ["wakatime/vim-wakatime"] = { -- Wakatime integration
    after = "nvim-lspconfig",
  },
  ["CRAG666/code_runner.nvim"] = { -- Quickly run script inside vim
    requires = "nvim-lua/plenary.nvim",
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.code_runner"
    end,
  },
  ["akinsho/toggleterm.nvim"] = {
    tag = "*",
    config = function()
      require("toggleterm").setup {
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
