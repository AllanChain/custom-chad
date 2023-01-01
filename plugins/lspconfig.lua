local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local servers = {
  "html",
  "cssls",
  "julials",
  "astro",
  "volar",
  "svelte",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.tsserver.setup {
  on_attach = function(client, _)
    client.server_capabilities.document_formatting = false
  end,
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
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
        missingrefs = "none"
      }
    }
  }
}
