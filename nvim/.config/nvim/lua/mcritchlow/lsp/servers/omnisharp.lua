local M = {}
M.setup = function(_on_attach, _capabilities)
    vim.lsp.config("omnisharp", {
        enable_editorconfig_support = true,
        enable_roslyn_analyzers = true,
    })
    vim.lsp.enable("omnisharp")
end

return M
