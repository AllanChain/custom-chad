-- IMPORTANT NOTE : This is the user config, can be edited. Will be preserved if updated with internal updater
-- This file is for NvChad options & tools, custom settings are split between here and 'lua/custom/init.lua'
-- local cmp = require('cmp')
local M = {}
M.options, M.ui, M.mappings, M.plugins = {}, {}, {}, {}

M.mappings = require("custom.mappings")

M.ui = {
	transparency = true,
	theme = "doomchad",
}

M.plugins = require "custom.plugins"

-- NvChad included plugin options & overrides
-- local userPlugins = require "custom.plugins"
-- M.plugins = {
--    status = {
--       dashboard = true,
--    },
--    options = {
--       lspconfig = {
--          setup_lspconf = "custom.plugins.lspconfig",
--       },
--    },
--    -- To change the Packer `config` of a plugin that comes with NvChad,
--    -- add a table entry below matching the plugin github name
--    --              '-' -> '_', remove any '.lua', '.nvim' extensions
--    -- this string will be called in a `require`
--    --              use "(custom.configs).my_func()" to call a function
--    --              use "custom.blankline" to call a file
--    default_plugin_config_replace = {
--       nvim_cmp = {
--          mappings = {
--             ["<CR>"] = cmp.config.disable,
--             -- ["<CR>"] = cmp.mapping.confirm {
--             --    select = false,
--             -- },
--          },
--       },
--    },
--    install = userPlugins,
-- }
return M
