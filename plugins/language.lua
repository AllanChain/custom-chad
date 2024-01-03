--[[======================================================
--            Language-specific dev plugins
--======================================================]]
return {
  {
    "JuliaEditorSupport/julia-vim",
    lazy = false,
    ft = { "julia" },
  },
  { -- Neovim config intellisense. See lspconfig setup
    "folke/neodev.nvim",
  },
  {
    "stevearc/aerial.nvim",
    event = "BufReadPost",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("aerial").setup {
        on_attach = function(bufnr)
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      }
      -- use AerialToggle! to retain cursor focus
      vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle<CR>")
    end,
  },
}
