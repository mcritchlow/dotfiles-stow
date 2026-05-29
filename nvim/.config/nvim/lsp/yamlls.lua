-- Per-server settings; merged with nvim-lspconfig's lsp/yamlls.lua defaults
-- (cmd/filetypes/root_markers) and the shared "*" config in lua/mcritchlow/lsp.
return {
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
}
