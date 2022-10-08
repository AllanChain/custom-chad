return {
  ["tpope/vim-sleuth"] = {},
  ["JuliaEditorSupport/julia-vim"] = {},
  -- ["arthurxavierx/vim-unicoder"] = {},
  ["folke/which-key.nvim"] = {
    disable = false,
    module = "which-key",
    keys = { "<leader>", '"', "'", "`", "g" },
  },
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = {
      indent = {
        disable = { "julia" }
      },
    },
  },

  ["hrsh7th/nvim-cmp"] = {
    override_options = require "custom.plugins.cmp"
  },
  ["goolord/alpha-nvim"] = {
    disable = false,
    cmd = "Alpha",
  },
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
