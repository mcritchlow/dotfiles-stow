local ok, mason = pcall(require, "mason")

if not ok then
  return
end

-- Enable debug logging if/when needed
-- vim.lsp.set_log_level("debug")

-- Some LSP UI customization
local signs = require("mcritchlow.utils").signs
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Floating border
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or { { " ", "FloatBorder" } }
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Set borders
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})

-- we want no virtual_text but show via hover
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
})

-- For auto-format w/ lsp on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
  require("mcritchlow.utils").lsp_keymaps(bufnr)
  -- if client.supports_method("textDocument/formatting") then
  --   vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --   vim.api.nvim_create_autocmd("BufWritePre", {
  --     group = augroup,
  --     buffer = bufnr,
  --     callback = function()
  --       vim.lsp.buf.format({ bufnr = bufnr })
  --     end,
  --   })
  -- end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Install LSP servers
mason.setup {
  automatic_installation = true,
  ui = {
    border = 'single',
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    },
  },
}

local servers = {
  "bashls",
  "docker_compose_language_service",
  "dockerls",
  "gopls",
  "jsonls",
  "lua_ls",
  "standardrb",
  "yamlls",
}

require("mason-lspconfig").setup {
  ensure_installed = servers
}

-- Create separate table to include null-ls for setup
-- mason-lspconfig gets confused if we add null-ls
local lsp_servers = { "null-ls" }
for _, s in ipairs(servers) do
  table.insert(lsp_servers, s)
end

for _, server in ipairs(lsp_servers) do
  require("mcritchlow.lsp.servers." .. server).setup(on_attach, capabilities)
end
