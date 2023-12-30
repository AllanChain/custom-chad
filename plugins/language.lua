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
}
