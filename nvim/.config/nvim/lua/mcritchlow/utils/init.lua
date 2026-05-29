local _M = {}

-- Support dynamically reloading lua modules in config
_M.reload_module = function(name)
    local ok, plenary = pcall(require, "plenary.reload")
    if not ok then
        return
    end
    plenary.reload_module(name)
    require(name)
end

-- Setup vim-test for container name in docker-compose
-- @parameter service -- docker service name (usually app or web)
_M.setup_vim_test = function(service)
    vim.g["test#ruby#rspec#executable"] = "docker-compose-test " .. service
end

_M.setup_standardrb = function(service, cwd_suffix)
    cwd_suffix = cwd_suffix or ""
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local on_attach = function(client, bufnr)
        require("mcritchlow.utils").lsp_keymaps(bufnr)
    end

    vim.lsp.config("standardrb", {
        on_attach = on_attach,
        cmd = { "docker-compose-exec", service, "standardrb", "--lsp" },
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
    })
    vim.lsp.enable("standardrb")
end

_M.setup_standardrb_bundle = function(service, cwd_suffix)
    cwd_suffix = cwd_suffix or ""
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local on_attach = function(client, bufnr)
        require("mcritchlow.utils").lsp_keymaps(bufnr)
    end

    vim.lsp.config("standardrb", {
        on_attach = on_attach,
        cmd = { "docker-compose-exec", service, "bundle", "exec", "standardrb", "--lsp" },
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
    })
    vim.lsp.enable("standardrb")
end

-- Setup null-ls to use standardrb for lint/format
-- @parameter service -- docker service name (usually app or web)
-- @parameter cwd_suffix -- subpath to project if not in the root of git repo (surfliner)
_M.setup_null_ls = function(service, cwd_suffix)
    cwd_suffix = cwd_suffix or ""
    -- Null-ls configuration
    local null_ls = require("null-ls")
    local util = require("null-ls.utils")

    local null_ls_sources = {
        null_ls.builtins.diagnostics.standardrb.with({
            cwd = function(params)
                return util.root_pattern(".git")(vim.fn.getcwd()) .. cwd_suffix
            end,
            command = "docker-compose-exec",
            args = { service, "bundle", "exec", "standardrb", " --no-fix", "-f", "json", "--stdin", "$FILENAME" },
        }),
        null_ls.builtins.formatting.standardrb.with({
            cwd = function(params)
                return util.root_pattern(".git")(vim.fn.getcwd()) .. cwd_suffix
            end,
            command = "docker-compose-exec",
            args = { service, "bundle", "exec", "standardrb", " --fix", "--format", "quiet", "--stderr", "--stdin", "$FILENAME" },
        }),
    }
    null_ls.register(null_ls_sources)
end
--
-- Setup null-ls to use golangci_lint for lint/format in go projects
_M.setup_null_ls_go = function()
    cwd_suffix = cwd_suffix or ""
    -- Null-ls configuration
    local null_ls = require("null-ls")

    local null_ls_sources = { null_ls.builtins.diagnostics.golangci_lint }
    null_ls.register(null_ls_sources)
end

-- Example usage
-- utils.set_spaces_size{ go = 4, ruby = 2, python = 4, java = 4 }
_M.set_spaces_size = function(filetypes)
    for filetype, size in pairs(filetypes) do
        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetype,
            callback = function()
                vim.opt.shiftwidth = size
                vim.opt.tabstop = size
            end,
        })
    end
end

-- Signs for tree view, diagnostics, etc
_M.signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

-- Get the index of an array/list item
-- Example usage
-- utils.index_of(my_array, "an-item") -> 3
_M.index_of = function(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i
        end
    end
    return nil
end

-- Replace term codes using preset settings
-- Example usage
-- utils.replace_term_codes("<Esc>")
_M.replace_term_codes = function(value)
    return vim.api.nvim_replace_termcodes(value, true, true, true)
end

-- Default LSP keymaps
_M.lsp_keymaps = function(bufnr)
    local wk = require('which-key')
    -- Neovim 0.11+ provides these LSP keymaps by default on every LSP buffer,
    -- so we no longer define our own. Learning the defaults (see :h lsp-defaults):
    --
    --   K            hover docs            (was <leader>lh)
    --   grn          rename symbol         (was <leader>ln)
    --   gra          code action (n + v)   (was <leader>lca)
    --   grt          type definition       (was <leader>ltd)
    --   grr          references            (also <leader>lr, via Telescope)
    --   gri          implementations       (also <leader>li, via Telescope)
    --   gO           document symbols      (also <leader>lso, via Telescope)
    --   <C-s> (insert mode)  signature help (was <leader>lsh)
    --   [d / ]d      prev/next diagnostic  (defined globally, see mappings)
    --   CTRL-W d     show line diagnostics
    --
    -- Below we keep only maps the defaults don't cover: declaration (no default
    -- keymap), plus Telescope-backed versions of references/implementations/
    -- symbols (the grr/gri/gO defaults use the quickfix list, not Telescope).
    wk.add({
        { "<leader>lD",  vim.lsp.buf.declaration,                   buffer = bufnr, desc = "[LSP] Declaration (no default; cf. grn/gra)", nowait = true, remap = false },
        { "<leader>ld",  "<cmd>Telescope lsp_definitions<cr>",      buffer = bufnr, desc = "[LSP] Definitions (Telescope)",     nowait = true, remap = false },
        { "<leader>li",  "<cmd>Telescope lsp_implementations<cr>",  buffer = bufnr, desc = "[LSP] Implementations (Telescope; default gri)", nowait = true, remap = false },
        { "<leader>lr",  "<cmd>Telescope lsp_references<cr>",       buffer = bufnr, desc = "[LSP] References (Telescope; default grr)",      nowait = true, remap = false },
        { "<leader>lso", "<cmd>Telescope lsp_document_symbols<cr>", buffer = bufnr, desc = "[LSP] Document Symbols (Telescope; default gO)", nowait = true, remap = false },
    })

    -- Surface the built-in 0.11+ LSP defaults in the which-key popup so they're
    -- easy to discover/learn. These keys are already mapped by Neovim; we only
    -- attach labels (no `rhs`, so we don't override the default behavior).
    wk.add({
        { "gr", group = "[LSP] goto/refactor", buffer = bufnr },
        { "grn", desc = "[LSP] Rename",           buffer = bufnr },
        { "gra", desc = "[LSP] Code Action",      buffer = bufnr },
        { "grr", desc = "[LSP] References",       buffer = bufnr },
        { "gri", desc = "[LSP] Implementations",  buffer = bufnr },
        { "grt", desc = "[LSP] Type Definition",  buffer = bufnr },
        { "gO",  desc = "[LSP] Document Symbols", buffer = bufnr },
        { "K",   desc = "[LSP] Hover",            buffer = bufnr },
    })
end

return _M
