return {
  ["tpope/vim-sleuth"] = {},
  ["JuliaEditorSupport/julia-vim"] = {},
  ["ahmedkhalf/project.nvim"] = {
    config = function()
      require("project_nvim").setup {
        -- detection_methods = { "lsp", "pattern" },
      }
    end,
  },
  -- ["arthurxavierx/vim-unicoder"] = {},
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
    },
  },
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = {
      indent = {
        enable = false,
      },
    },
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
    },
  },
  ["hrsh7th/nvim-cmp"] = {
    override_options = require "custom.plugins.cmp",
  },
  ["goolord/alpha-nvim"] = {
    disable = false,
    cmd = "Alpha",
  },
  ["tpope/vim-surround"] = {},
  ["wakatime/vim-wakatime"] = {
    after = "nvim-lspconfig",
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },
  ["CRAG666/code_runner.nvim"] = {
    requires = "nvim-lua/plenary.nvim",
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.code_runner"
    end,
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
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
