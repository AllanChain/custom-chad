local M = {}

M.mappings = require "custom.mappings"

M.ui = {
  theme = "onenord",
}

M.plugins = "custom.plugins"
M.lazy_nvim = {
  git = {
    url_format = "https://ghproxy.com/github.com/%s.git",
  },
}

return M
