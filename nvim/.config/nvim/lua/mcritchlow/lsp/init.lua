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

-- Border for all floating windows (LSP hover, signature help, etc.)
vim.o.winborder = "single"

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

-- Shared defaults merged into every LSP server via vim.lsp.config (nvim 0.11+).
-- Per-server settings live in ~/.config/nvim/lsp/<name>.lua and are
-- auto-discovered, then merged on top of nvim-lspconfig's shipped defaults.
vim.lsp.config("*", {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})

-- Install LSP server binaries
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

-- Servers auto-started via native lsp/ discovery + vim.lsp.enable().
-- gopls is excluded: it's installed here but configured/started by go.nvim.
local servers = {
  "ansiblels",
  "bashls",
  "docker_compose_language_service",
  "dockerls",
  "jsonls",
  "lua_ls",
  "yamlls",
}

require("mason-lspconfig").setup {
  ensure_installed = vim.list_extend({ "gopls" }, vim.deepcopy(servers)),
}

-- neodev configures the Lua library/globals for the nvim API; must run before
-- lua_ls starts.
require("neodev").setup({})

vim.lsp.enable(servers)

-- Servers that can't use native lsp/ discovery:
--   gopls  - driven by go.nvim
--   null-ls - none-ls, not a real LSP server
require("mcritchlow.lsp.servers.gopls").setup(on_attach, capabilities)
require("mcritchlow.lsp.servers.null-ls").setup(on_attach, capabilities)
