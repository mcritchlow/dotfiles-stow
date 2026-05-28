local M = {}
M.setup = function(_on_attach, capabilities)
  local go_caps = vim.tbl_deep_extend("force", capabilities or {}, {
    textDocument = {
      completion = {
        completionItem = {
          commitCharactersSupport = true,
          deprecatedSupport = true,
          documentationFormat = { "markdown", "plaintext" },
          preselectSupport = true,
          insertReplaceSupport = true,
          labelDetailsSupport = true,
          snippetSupport = true,
          resolveSupport = {
            properties = {
              "edit",
              "documentation",
              "details",
              "additionalTextEdits",
            },
          },
        },
        completionList = {
          itemDefaults = {
            "editRange",
            "insertTextFormat",
            "insertTextMode",
            "data",
          },
        },
        contextSupport = true,
        dynamicRegistration = true,
      },
    },
  })

  local ok_go, go = pcall(require, "go")

  if not ok_go then
    print("Go module not found!")
    return
  end

  local keymaps_func = require("mcritchlow.utils").keymaps

  go.setup({
    gopls_cmd = { vim.fs.joinpath(vim.fn.stdpath 'data', 'mason', 'bin', 'gopls') },
    fillstruct = 'gopls',
    dap_debug = true,
    dap_debug_gui = true,
    dap_debug_vt = true,
    lsp_keymaps = keymaps_func,
    lsp_cfg = {
      capabilities = go_caps,
    },
    lsp_inlay_hints = {
      enable = true,
    }
  })

  vim.lsp.config("gopls", {
    filetypes = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
    capabilities = go_caps,
    settings = {
      gopls = {
        analyses = {
          append = true,
          asmdecl = true,
          assign = true,
          atomic = true,
          unreachable = true,
          nilness = true,
          ST1003 = true,
          undeclaredname = true,
          fillreturns = true,
          nonewvars = true,
          shadow = true,
          unusedvariable = true,
          unusedparams = true,
          useany = true,
          unusedwrite = true,
        },
        codelenses = {
          generate = true,
          gc_details = false,
          test = true,
          tidy = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        matcher = "Fuzzy",
        diagnosticsDelay = "500ms",
        symbolMatcher = "fuzzy",
      }
    },
  })
  vim.lsp.enable("gopls")
end

return M
