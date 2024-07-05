vim.cmd [[
  let g:test#harpoon_term = 2
  let test#strategy = {
    \ 'nearest': 'neovim',
    \ 'last':   'neovim',
    \ 'file':    'harpoon',
    \ 'suite':   'harpoon',
  \}
]]
