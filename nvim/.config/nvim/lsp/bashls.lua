-- Per-server settings; merged with nvim-lspconfig's lsp/bashls.lua defaults
-- (cmd/filetypes/root_markers) and the shared "*" config in lua/mcritchlow/lsp.
return {
  settings = {
    bashIde = {
      highlightParsingErrors = true, -- let shellcheck do this
    },
  },
}
