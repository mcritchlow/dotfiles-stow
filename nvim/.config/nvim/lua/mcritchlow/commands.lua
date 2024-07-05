-- Format buffer using LSP
vim.api.nvim_create_user_command("Format", function()
  vim.lsp.buf.format( { async = true } )
end, {
  desc = "Format buffer with LSP"
})

-- Copy current file (including line number) remote Git URL to clipboard
-- Examples:
-- https://gitlab.com/ucsdlibrary/development/highfive/blob/fix-secret-guard/chart/templates/deployment.yaml#L42-43
-- https://git.sr.ht/~mcritchlow/dotfiles/tree/trunk/ideavimrc#L6-7
vim.api.nvim_create_user_command("GitUrl", function(args)
  local Job = require('plenary.job')
  local git_url_result = {}

  Job:new({
    command = 'git-url',
    args = { vim.fn.expand("%:p"), args["line1"], args["line2"] },
    on_stdout = function(_, line)
      print("copying to clipboard " .. line)
      table.insert(git_url_result, line)
    end,
  }):sync()

  -- copy url to clipboard register
  vim.fn.setreg("+", git_url_result[1])
end, {
  range = true,
  desc = "Copy Git remote URL to clipboard"
})
