local M = {}

M.mappings = require "custom.mappings"

M.ui = {
  hl_add = {
    ConflictCurrent = { bg = "light_bg" },
    ConflictIncoming = { bg = "one_bg" },
  },
  theme = "onenord",
  statusline = {
    overriden_modules = function()
      return {
        LSP_status = function()
          local client_names = {}
          local client_count = 0
          if rawget(vim, "lsp") then
            for _, client in ipairs(vim.lsp.get_active_clients()) do
              if client.attached_buffers[vim.api.nvim_get_current_buf()] then
                client_count = client_count + 1
                local client_name = client.name:gsub("[_-]lsp?$", "")
                client_name = client_name:gsub("[_-]language[_-]server$", "")
                client_names[client_count] = client_name
                if client_count == 3 then
                  break
                end
              end
            end
          end
          if client_count == 0 then
            return ""
          end
          if vim.o.columns <= 100 then
            return "  "
          end
          return "%#St_LspStatus#" .. "  " .. table.concat(client_names, "|") .. " "
        end,
      }
    end,
  },
}

M.plugins = "custom.plugins"
M.lazy_nvim = {
  git = {
    url_format = "https://mirror.ghproxy.com/github.com/%s.git",
  },
}

return M
