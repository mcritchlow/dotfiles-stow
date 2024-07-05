local M = {}
M.setup = function(on_attach, capabilities)
    local lspconfig = require("lspconfig")
    local json_caps = capabilities
    json_caps.textDocument.completion.completionItem.snippetSupport = true

    lspconfig.jsonls.setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = json_caps,
        settings = {
            json = {
                format = { enable = true },
                validate = { enable = true },
                schemas = require('schemastore').json.schemas(),
            }
        }
    }
end

return M
