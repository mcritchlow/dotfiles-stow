local M = {}
M.setup = function(on_attach, capabilities)
    local lspconfig = require "lspconfig"

    lspconfig.omnisharp.setup {
        on_attach = on_attach,
        enable_editorconfig_support = true,
        -- enable_ms_build_load_projects_on_demand = true,
        -- analyze_open_documents_only = true,
        enable_roslyn_analyzers = true,
        -- enable_import_completion = true, -- might be slow!
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
    }
end

return M
