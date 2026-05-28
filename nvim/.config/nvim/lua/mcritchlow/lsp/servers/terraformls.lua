local M = {}
M.setup = function(_on_attach, _capabilities)
    vim.lsp.enable("terraformls")
end

return M
