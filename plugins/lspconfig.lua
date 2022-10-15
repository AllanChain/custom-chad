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
    root_dir = vim.loop.cwd,
    flags = {
      debounce_text_changes = 150,
    },
  }
end

lspconfig.tsserver.setup {
  on_attach = function(client, _)
    client.resolved_capabilities.document_formatting = false
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
