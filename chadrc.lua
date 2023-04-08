local M = {}

M.mappings = require "custom.mappings"

M.ui = {
  theme = "onenord",
  statusline = {
    overriden_modules = function ()
      return {
        LSP_progress = function ()
          return ""
        end
      }
    end
  }
}

M.plugins = "custom.plugins"
M.lazy_nvim = {
  git = {
    url_format = "https://ghproxy.com/github.com/%s.git",
  },
}

return M
