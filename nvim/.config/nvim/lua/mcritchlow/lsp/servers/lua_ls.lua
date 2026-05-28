local M = {}

M.setup = function(on_attach, capabilities)
  require("neodev").setup({
    lspconfig = {
      capabilities = capabilities,
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      },
    },
  })

  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  })
  vim.lsp.enable("lua_ls")
end

return M
