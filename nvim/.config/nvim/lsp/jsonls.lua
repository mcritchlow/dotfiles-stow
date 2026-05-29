-- Per-server settings; merged with nvim-lspconfig's lsp/jsonls.lua defaults
-- (cmd/filetypes/root_markers) and the shared "*" config in lua/mcritchlow/lsp.
return {
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
    },
  },
  settings = {
    json = {
      format = { enable = true },
      validate = { enable = true },
      schemas = require("schemastore").json.schemas(),
    },
  },
}
