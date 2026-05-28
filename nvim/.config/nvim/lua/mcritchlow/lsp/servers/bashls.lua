local M = {}
M.setup = function(_on_attach, _capabilities)
    vim.lsp.config("bashls", {
        settings = {
            bashIde = {
                highlightParsingErrors = true -- let shellcheck do this
            }
        }
    })
    vim.lsp.enable("bashls")
end

return M
