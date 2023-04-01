local M = {}
M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

M.mappings = require("custom.mappings")

M.ui = {
	theme = "doomchad",
}

M.plugins = require "custom.plugins"

return M
