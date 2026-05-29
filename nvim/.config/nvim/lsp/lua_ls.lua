-- Per-server settings; merged with nvim-lspconfig's lsp/lua_ls.lua defaults
-- (cmd/filetypes/root_markers) and the shared "*" config in lua/mcritchlow/lsp.
-- neodev (which configures the Lua library/globals for the nvim API) is set up
-- in lua/mcritchlow/lsp/init.lua before the client starts.
return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}
