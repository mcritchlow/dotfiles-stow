local utils = require("mcritchlow.utils")

vim.g.mapleader = ","

vim.cmd [[filetype plugin indent on]]

-- see: help option-list
local options = {
  background = "light",
  completeopt = { 'menuone', 'noinsert' },
  cursorline = true,
  exrc = true,
  fileencoding = "utf-8",
  ignorecase = true,
  number = true,
  numberwidth = 5,
  path = { ".", "**" },
  relativenumber = true,
  smartcase = true,
  splitbelow = true,
  splitright = true,
  statusline = "%<%F %y %{FugitiveStatusline()} %q%h%m%r%=%-14.(%03l,%02c%V%) %P",
  swapfile = false,
  tagcase = "followscs",
  termguicolors = true,
  textwidth = 120,
}

utils.set_spaces_size { python = 4, rust = 4, markdown = 4, css = 2, html = 2, javascript = 2 }
-- utils.set_spaces_size { go = 4, python = 4, rust = 4, markdown = 4, css = 2, html = 2, javascript = 2 }

-- Append, prepend, etc. stuff
vim.opt.tags:append(".git/tags")
vim.opt.wildignore:prepend({ "tmp/**", "**/node_modules/**"})
vim.opt.diffopt:append('vertical')

for key, value in pairs(options) do
  vim.opt[key] = value
end
