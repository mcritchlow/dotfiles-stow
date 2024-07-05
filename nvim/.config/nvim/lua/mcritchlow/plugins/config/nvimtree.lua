local ok, nvimtree = pcall(require, "nvim-tree")

if not ok then
    return
end

local signs = require("mcritchlow.utils").signs

nvimtree.setup {
    disable_netrw = true,
    diagnostics = {
        enable = false,
        icons = {
            hint = signs.Hint,
            info = signs.Info,
            warning = signs.Warning,
            error = signs.Error,
        },
    },
    filters = {
        dotfiles = false,
        custom = {
            "^.git$",
        },
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 500,
    },
}
