local M = {}
M.setup = function(on_attach, capabilities)
    local lspconfig = require "lspconfig"

    lspconfig.standardrb.setup {
        on_attach = on_attach,
        cmd = { "standardrb", "--lsp" },
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
    }
end

return M
