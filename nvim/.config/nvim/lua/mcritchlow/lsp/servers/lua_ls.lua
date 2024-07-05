local M = {}

M.setup = function(on_attach, capabilities)
  require("neodev").setup({
    -- add any options here, or leave empty to use the default settings
    lspconfig = {
      capabilities = capabilities,
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      },
    },
  })

  local lspconfig = require("lspconfig")
  lspconfig.lua_ls.setup({
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace"
        }
      }
    },
    lspconfig = {
      capabilities = capabilities,
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      },
    },
  })
end

return M
