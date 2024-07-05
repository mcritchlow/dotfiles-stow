-- for catppuccin theme
-- You NEED to override nvim-dap's default highlight groups, AFTER requiring nvim-dap
require("dap")
local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})

-- virtual text setup
require("nvim-dap-virtual-text").setup()

-- dap-ui setup
require("dapui").setup()
