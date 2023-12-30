--[[======================================================
--                   UI and highlighting
--======================================================]]
return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      local base30 = require("base46").get_theme_tb "base_30"
      require("bufferline").setup {
        options = {
          separator_style = "slope",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              separator = '  ', -- use a "true" to enable the default, or set your own character
            },
          },
        },
        highlights = {
          fill = {
            bg = base30.darker_black,
          },
          separator_selected = {
            fg = base30.darker_black,
          },
          separator_visible = {
            fg = base30.darker_black,
          },
          separator = {
            fg = base30.darker_black,
          },
        },
      }
    end,
  },
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
