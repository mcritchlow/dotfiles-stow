local M = {}
M.setup = function(_on_attach, _capabilities)
    vim.lsp.enable("docker_compose_language_service")
end

return M
