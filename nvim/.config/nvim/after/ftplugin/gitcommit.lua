local options = {
  spell = true,
}

for key, value in pairs(options) do
  vim.opt_local[key] = value
end
