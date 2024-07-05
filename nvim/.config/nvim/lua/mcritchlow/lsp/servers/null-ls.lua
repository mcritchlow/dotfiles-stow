local ok, null_ls = pcall(require, "null-ls")

if not ok then
    return
end
--
-- To register project-specific sources:
-- Set something like the following in a project vimrc.local file
-- local null_ls = require("null-ls")
-- local null_ls_sources = {
--   null_ls.builtins.diagnostics.standardrb.with({
--     command = "bin/null-ls-exec",
--     args = { "standardrb"," --no-fix", "-f", "json", "--stdin", "$FILENAME" },
--   }),
--   null_ls.builtins.formatting.standardrb.with({
--     command = "bin/null-ls-exec",
--     args = { "standardrb"," --fix", "--format", "quiet", "--stderr", "--stdin", "$FILENAME" },
--   }),
-- }
-- null_ls.register(null_ls_sources)

local M = {}
M.setup = function(on_attach, capabilities)
    null_ls.setup {
        -- debug = true,
        sources = {},
        on_attach = on_attach,
        capabilities = capabilities
    }
    -- null_ls.setup({ debug = true, sources = null_ls_sources }) -- for DEBUG
end

return M
