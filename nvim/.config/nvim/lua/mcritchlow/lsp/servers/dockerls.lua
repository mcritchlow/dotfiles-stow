local M = {}
M.setup = function(_on_attach, _capabilities)
    vim.lsp.enable("dockerls")
end

return M
