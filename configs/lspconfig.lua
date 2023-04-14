local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

---@diagnostic disable-next-line:different-requires
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end
local util = require "lspconfig/util"

local path = util.path
local exepath = util.exepath

local servers = {
  "html",
  "cssls",
  "julials",
  "astro",
  "volar",
  "svelte",
  "jsonls",
  "emmet_ls",
}

for _, lsp in ipairs(servers) do
  local executable = lspconfig[lsp].document_config.default_config.cmd[1]
  if vim.fn.executable(executable) ~= 0 then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
end

lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    client.server_capabilities.document_formatting = false
  end,
}

-- https://github.com/neovim/nvim-lspconfig/issues/500
local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end
  -- Find and use virtualenv via poetry in workspace directory.
  local match = vim.fn.glob(path.join(workspace, "poetry.lock"))
  if match ~= "" then
    local venv = vim.fn.trim(vim.fn.system "poetry env info -p")
    return path.join(venv, "bin", "python")
  end
  -- Fallback to system Python.
  return exepath "python3" or exepath "python" or "python"
end

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  before_init = function(_, config)
    config.settings.python.pythonPath = get_python_path(config.root_dir)
  end,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
      },
    },
  },
}

lspconfig.julials.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    julia = {
      lint = {
        missingrefs = "none",
      },
    },
  },
}
