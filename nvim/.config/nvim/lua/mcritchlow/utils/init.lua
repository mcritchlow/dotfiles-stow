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
    local lspconfig = require "lspconfig"

    lspconfig.standardrb.setup {
        on_attach = on_attach,
        cmd = { "docker-compose-exec", service, "standardrb", "--lsp" },
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = capabilities,
    }
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
    -- TODO: finish setting up which-key for lsp buffer mappings
    local wk = require('which-key')
    -- normal mode
    local wk_opts = {
        mode = "n",
        buffer = bufnr,
        noremap = true,
        nowait = true,
        prefix = "",
        silent = true,
    }
    -- normal mode
    local vwk_opts = {
        mode = "v",
        buffer = bufnr,
        noremap = true,
        nowait = true,
        prefix = "",
        silent = true,
    }
    local telescope = require('telescope.builtin')
    local opts = { buffer = bufnr }
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    --
    wk.register({
        ["<leader>l"] = {
            D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "[LSP] Hover" },
            d = { "<cmd>Telescope lsp_definitions<cr>", "[LSP] Definitions" },
            td = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "[LSP] Type Definition" },
            h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "[LSP] Hover" },
            n = { "<cmd>lua vim.lsp.buf.rename()<cr>", "[LSP] Rename" },
            r = { "<cmd>Telescope lsp_references<cr>", "[LSP] References" },
            i = { "<cmd>Telescope lsp_implementations<cr>", "[LSP] Implementations" },
            ca = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "[LSP] Code Actions" },
            so = { "<cmd>Telescope lsp_document_symbols<cr>", "[LSP] Document Symbols" },
            sh = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "[LSP] Signature Help" },
        }
    }, wk_opts)

    wk.register({
        ["<leader>l"] = {
            ca = { "<cmd>lua vim.lsp.buf.range_code_action()<CR>", "[LSP] Code Actions" },
        }
    }, vwk_opts)

    -- wk.reg

    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    -- vim.keymap.set('n', 'gd', telescope.lsp_definitions, opts)
    -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    -- vim.keymap.set('n', 'gi', telescope.lsp_implementations, opts)
    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<leader>wl', function()
    --   vim.inspect(vim.lsp.buf.list_workspace_folders())
    -- end, opts)
    -- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    -- vim.keymap.set('n', 'gr', telescope.lsp_references, opts)
    -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', '<leader>so', telescope.lsp_document_symbols, opts)
end

return _M
