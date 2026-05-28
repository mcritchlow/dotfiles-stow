local ok, treesitter = pcall(require, "nvim-treesitter")

if not ok then
  return
end

local ts_languages = {
  "bash",
  "dockerfile",
  "go",
  "java",
  "javascript",
  "json",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "regex",
  "ruby",
  "rust",
  "scss",
  "vim",
  "vimdoc",
  "yaml"
}

-- main branch installs parsers/queries into install_dir (default: stdpath data /site).
-- This is a no-op for parsers that are already installed and up to date.
treesitter.install(ts_languages)

-- On main, highlighting and indentation are NOT plugin options. Highlighting is
-- Neovim's native treesitter (vim.treesitter.start) and indentation is the
-- plugin's experimental indentexpr. Enable both per-buffer on FileType.
local ts_group = vim.api.nvim_create_augroup("mcritchlow_treesitter", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = ts_group,
  callback = function(args)
    local bufnr = args.buf

    -- start() derives the language from the buffer's filetype and errors when no
    -- parser is installed for it; bail out quietly in that case.
    if not pcall(vim.treesitter.start, bufnr) then
      return
    end

    -- Treesitter-based indentation is experimental upstream and Ruby's is
    -- unreliable, so keep it disabled there (matches the old `disable` list).
    if vim.bo[bufnr].filetype ~= "ruby" then
      vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
