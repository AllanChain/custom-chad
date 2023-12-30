--[[======================================================
--                   UI and highlighting
--======================================================]]
return {
  {
    "stevearc/dressing.nvim",
    event = "VimEnter",
    opts = {},
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
  { -- Dim unused vars
    "zbirenbaum/neodim",
    event = "LspAttach",
    -- TODO: Remove the constrain after NeoVim 0.10.0
    commit = "f11c110",
    opts = {
      alpha = 0.5,
      blend_color = "#2e3440",
    },
    config = function(_, opts)
      require("neodim").setup(opts)
    end,
  },
  {
    "Bekaboo/deadcolumn.nvim",
    event = "BufReadPost",
  },
}
