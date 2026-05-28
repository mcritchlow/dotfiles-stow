local M = {}
M.setup = function(_on_attach, capabilities)
    local json_caps = vim.tbl_deep_extend("force", capabilities or {}, {
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true,
                },
            },
        },
    })

    vim.lsp.config("jsonls", {
        capabilities = json_caps,
        settings = {
            json = {
                format = { enable = true },
                validate = { enable = true },
                schemas = require('schemastore').json.schemas(),
            }
        }
    })
    vim.lsp.enable("jsonls")
end

return M
