local options = {
  autoindent = true,
  expandtab = true,
  tabstop = 4,
  textwidth = 79,
}

for key, value in pairs(options) do
  vim.opt_local[key] = value
end
