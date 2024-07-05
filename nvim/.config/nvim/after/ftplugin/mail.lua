local options = {
  spell = true,
  list = false,
}

for key, value in pairs(options) do
  vim.opt_local[key] = value
end
