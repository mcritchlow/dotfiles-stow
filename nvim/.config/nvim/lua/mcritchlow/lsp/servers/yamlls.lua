local M = {}
M.setup = function(_on_attach, _capabilities)
    vim.lsp.config("yamlls", {
        root_dir = function(bufnr, cb)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local root = vim.fs.root(fname ~= "" and fname or bufnr, { ".git" })
            cb(root or vim.fn.getcwd())
        end,
        single_file_support = true,
        settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
                customTags = { "!reference sequence" },
                completion = true,
                schemaStore = {
                    enable = true,
                    url = "https://www.schemastore.org/api/json/catalog.json",
                },
                schemas = {
                    ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = { "*.gitlab-ci.yml", "ci/**/*.yml" }
                },
            },
        },
    })
    vim.lsp.enable("yamlls")
end

return M
