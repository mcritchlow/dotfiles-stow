local ok, textobjects = pcall(require, "nvim-treesitter-textobjects")

if not ok then
  return
end

textobjects.setup {
  select = {
    -- Automatically jump forward to a textobject, similar to targets.vim
    lookahead = true,
    selection_modes = {
      ["@function.outer"] = "V", -- linewise
    },
  },
  move = {
    set_jumps = true, -- store movements in the jumplist
  },
}

local select = require("nvim-treesitter-textobjects.select")
local swap = require("nvim-treesitter-textobjects.swap")
local move = require("nvim-treesitter-textobjects.move")

-- select: capture group -> mapping (x/o modes), using the textobjects.scm queries
local select_keymaps = {
  ["af"] = "@function.outer",
  ["if"] = "@function.inner",
  ["aC"] = "@class.outer",
  ["iC"] = "@class.inner",
  ["ac"] = "@conditional.outer",
  ["ic"] = "@conditional.inner",
  ["ae"] = "@block.outer",
  ["ie"] = "@block.inner",
  ["al"] = "@loop.outer",
  ["il"] = "@loop.inner",
  ["as"] = "@statement.outer",
  ["is"] = "@statement.inner",
  ["ad"] = "@comment.outer",
  ["am"] = "@call.outer",
  ["im"] = "@call.inner",
}
for lhs, query in pairs(select_keymaps) do
  vim.keymap.set({ "x", "o" }, lhs, function()
    select.select_textobject(query, "textobjects")
  end, { desc = "Select " .. query })
end

-- swap parameters with the next/previous one
vim.keymap.set("n", "<leader>a", function()
  swap.swap_next("@parameter.inner")
end, { desc = "Swap next parameter" })
vim.keymap.set("n", "<leader>A", function()
  swap.swap_previous("@parameter.inner")
end, { desc = "Swap previous parameter" })

-- move: jump to next/previous function & class start/end
local move_keymaps = {
  ["]m"] = { move.goto_next_start, "@function.outer", "Next function start" },
  ["]]"] = { move.goto_next_start, "@class.outer", "Next class start" },
  ["]M"] = { move.goto_next_end, "@function.outer", "Next function end" },
  ["]["] = { move.goto_next_end, "@class.outer", "Next class end" },
  ["[m"] = { move.goto_previous_start, "@function.outer", "Previous function start" },
  ["[["] = { move.goto_previous_start, "@class.outer", "Previous class start" },
  ["[M"] = { move.goto_previous_end, "@function.outer", "Previous function end" },
  ["[]"] = { move.goto_previous_end, "@class.outer", "Previous class end" },
}
for lhs, spec in pairs(move_keymaps) do
  local fn, query, desc = spec[1], spec[2], spec[3]
  vim.keymap.set({ "n", "x", "o" }, lhs, function()
    fn(query, "textobjects")
  end, { desc = desc })
end
