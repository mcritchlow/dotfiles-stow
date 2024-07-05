local M = {}
M.setup = function(on_attach, capabilities)
    local lspconfig = require "lspconfig"

    lspconfig.yamlls.setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
        root_dir = require("lspconfig/util").find_git_ancestor,
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
    }
end

return M
