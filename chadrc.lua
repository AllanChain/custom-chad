local M = {}
M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

M.mappings = require("custom.mappings")

M.ui = {
	theme = "onedark",
}

M.plugins = "custom.plugins"
M.lazy_nvim = {
  git = {
    url_format = "https://ghproxy.com/github.com/%s.git",
  },
}

return M
