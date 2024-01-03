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
      local bar_bg = base30.one_bg
      require("bufferline.tabpages").get = require("custom.configs.tabpages").get
      require("bufferline").setup {
        options = {
          separator_style = "slope",
          modified_icon = "",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "StatusLine",
              separator = "  ", -- use a "true" to enable the default, or set your own character
            },
            {
              filetype = "aerial",
              text = "Aerial",
              highlight = "StatusLine",
              separator = true,
            }
          },
        },
        highlights = {
          fill = {
            bg = bar_bg,
          },
          tab_separator_selected = {
            fg = bar_bg,
          },
          tab_separator = {
            fg = bar_bg,
          },
          separator_selected = {
            fg = bar_bg,
          },
          separator_visible = {
            fg = bar_bg,
          },
          separator = {
            fg = bar_bg,
          },
          offset_separator = {
            bg = bar_bg,
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
    "folke/twilight.nvim",
    event = "BufReadPost",
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
