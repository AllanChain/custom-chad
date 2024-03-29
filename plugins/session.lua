--[[======================================================
--            Managing sessions and projects
--======================================================]]
return {
  {
    "tiagovla/scope.nvim",
    event = "VimEnter",
    config = function()
      require("scope").setup {}
    end,
  },
  {
    "ahmedkhalf/project.nvim", -- auto cd into project root
    lazy = false,
    config = function()
      local ok, project = pcall(require, "project_nvim")
      if not ok then
        return
      end
      project.setup {
        detection_methods = { "pattern", "lsp" },
        scope_chdir = "tab",
        silent_chdir = false,
      }
      local p = require "project_nvim.project"
      local history = require "project_nvim.utils.history"
      -- ensure current dir is added to the session
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local root, _ = p.get_project_root()
          table.insert(history.session_projects, root)
        end,
      })
    end,
  },
  {
    "okuuva/auto-save.nvim", -- auto save
    -- using the fork until https://github.com/Pocco81/auto-save.nvim/pull/67
    event = "BufReadPost",
    config = function()
      local ok, autosave = pcall(require, "auto-save")
      if not ok then
        return
      end
      local utils = require "auto-save.utils.data"
      autosave.setup {
        print_enabled = false,
        callbacks = {
          after_saving = function()
            local msg = "Saved at " .. vim.fn.strftime "%H:%M:%S"
            vim.notify(msg, vim.log.levels.INFO, {
              timeout = 100,
              title = "AutoSave",
              render = "compact",
            })
          end,
        },
        condition = function(buf)
          if vim.fn.getcwd():match "nvim/lua/custom" then
            return false
          end
          if
            vim.fn.getbufvar(buf, "&modifiable") == 1
            and utils.not_in(vim.fn.getbufvar(buf, "&filetype"), { "TelescopePrompt", "alpha" })
          then
            return true
          end
          return false
        end,
      }
    end,
  },
}
