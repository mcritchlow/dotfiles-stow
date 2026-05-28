local M = {}
M.setup = function(_on_attach, _capabilities)
    vim.lsp.config("standardrb", {
        cmd = { "standardrb", "--lsp" },
    })
    vim.lsp.enable("standardrb")
end

return M
