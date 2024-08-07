local ok, wk = pcall(require, "which-key")

if not ok then
	return
end

-- Set keymappings we don't need managed by which-key
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("t", "<C-o>", "<C-\\><C-n>")

-- vsnip mappings
local vsnip_mappings = {
	{
		mode = { "s", "i" },
		{ "<C-j>",   "vsnip#expandable() ? '<Plug>(vsnip-expand)': '<C-j>'",         desc = "[VSNIP] expand",           expr = true, replace_keycodes = false },
		{ "<C-l>",   "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)': '<C-l>'", desc = "[VSNIP] expand or jump",   expr = true, replace_keycodes = false },
		{ "<S-Tab>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)': '<S-Tab>'",    desc = "[VSNIP] jump to previous", expr = true, replace_keycodes = false },
		{ "<Tab>",   "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)': '<Tab>'",       desc = "[VSNIP] jump to next",     expr = true, replace_keycodes = false },
	},
}
wk.add(vsnip_mappings)
wk.add({
	{ "#",                "#zz",                                                                                            desc = "[MOVEMENT] Center '#' search",                nowait = true, remap = false },
	{ "*",                "*zz",                                                                                            desc = "[MOVEMENT] Center '*' search",                nowait = true, remap = false },
	{ "<C-n>",            "<cmd>NvimTreeToggle<cr> <cmd>NvimTreeRefresh<cr>",                                               desc = "[NVIMTREE] Toggle",                           nowait = true, remap = false },
	{ "<leader><leader>", "<c-^>",                                                                                          desc = "[MOVEMENT] Last file",                        nowait = true, remap = false },
	{ "<leader>d",        group = "[DAP]",                                                                                  nowait = true,                                        remap = false },
	{ "<leader>db",       "<cmd>GoBreakToggle<cr>",                                                                         desc = "[DAP] Toggle Breakpoint",                     nowait = true, remap = false },
	{ "<leader>dd",       "<cmd>GoDebug<cr>",                                                                               desc = "[DAP] Run debugger",                          nowait = true, remap = false },
	{ "<leader>dk",       "<cmd>GoDbgKeys<cr>",                                                                             desc = "[DAP] Show keymapping for debug mode",        nowait = true, remap = false },
	{ "<leader>dt",       "<cmd>GoDebug -t<cr>",                                                                            desc = "[DAP] Run debugger for tests",                nowait = true, remap = false },
	{ "<leader>f",        group = "[TELESCOPE]",                                                                            nowait = true,                                        remap = false },
	{ "<leader>fa",       "<cmd>lua require('telescope').extensions.githubcoauthors.coauthors()<CR>",                       desc = "[TELESCOPE] Git Authors",                     nowait = true, remap = false },
	{ "<leader>fb",       "<cmd>Telescope buffers<cr>",                                                                     desc = "[TELESCOPE] Find buffers",                    nowait = true, remap = false },
	{ "<leader>fc",       "<cmd>lua require('mcritchlow.plugins.config.telescope').git_commits_with_sha()<cr>",             desc = "[TELESCOPE] Marks",                           nowait = true, remap = false },
	{ "<leader>fd",       "<cmd>lua require('mcritchlow.plugins.config.telescope').search_dotfiles()<cr>",                  desc = "[TELESCOPE] Marks",                           nowait = true, remap = false },
	{ "<leader>ff",       "<cmd>Telescope find_files<cr>",                                                                  desc = "[TELESCOPE] Find buffers",                    nowait = true, remap = false },
	{ "<leader>fg",       "<cmd>Telescope git_branches<cr>",                                                                desc = "[TELESCOPE] Git branches",                    nowait = true, remap = false },
	{ "<leader>fh",       "<cmd>Telescope help_tags<cr>",                                                                   desc = "[TELESCOPE] Help tags",                       nowait = true, remap = false },
	{ "<leader>fm",       "<cmd>Telescope keymaps<cr>",                                                                     desc = "[TELESCOPE] Find keymappings",                nowait = true, remap = false },
	{ "<leader>fr",       "<cmd>lua require('mcritchlow.plugins.config.telescope').reload()<cr>",                           desc = "[TELESCOPE] Reload Config",                   nowait = true, remap = false },
	{ "<leader>fs",       "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})<CR>", desc = "[TELESCOPE] Find work by grep",               nowait = true, remap = false },
	{ "<leader>fw",       "<cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand('<cword>')})<cr>",     desc = "[TELESCOPE] Find word on cursor",             nowait = true, remap = false },
	{ "<leader>h",        group = "[HARPOON]",                                                                              nowait = true,                                        remap = false },
	{ "<leader>ha",       "<cmd>lua require('harpoon.ui').nav_file(1)<cr>",                                                 desc = "[HARPOON] Open File 1",                       nowait = true, remap = false },
	{ "<leader>hb",       "<cmd>lua require('harpoon.term').sendCommand(1,1)<cr>",                                          desc = "[HARPOON] Run Compose build",                 nowait = true, remap = false },
	{ "<leader>hc",       "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>",                                     desc = "[HARPOON] View command menu",                 nowait = true, remap = false },
	{ "<leader>hd",       "<cmd>lua require('harpoon.ui').nav_file(3)<cr>",                                                 desc = "[HARPOON] Open File 3",                       nowait = true, remap = false },
	{ "<leader>hf",       "<cmd>lua require('harpoon.ui').nav_file(4)<cr>",                                                 desc = "[HARPOON] Open File 4",                       nowait = true, remap = false },
	{ "<leader>hk",       "<cmd>lua require('harpoon.term').sendCommand(2,2)<cr>",                                          desc = "[HARPOON] Run Command 2 (compose down)",      nowait = true, remap = false },
	{ "<leader>hm",       "<cmd>lua require('harpoon.mark').add_file()<cr>",                                                desc = "[HARPOON] Add file",                          nowait = true, remap = false },
	{ "<leader>hs",       "<cmd>lua require('harpoon.ui').nav_file(2)<cr>",                                                 desc = "[HARPOON] Open File 2",                       nowait = true, remap = false },
	{ "<leader>ht",       "<cmd>lua require('harpoon.term').gotoTerminal(1)<cr>",                                           desc = "[HARPOON] Go to Terminal 1 (docker-compose)", nowait = true, remap = false },
	{ "<leader>hu",       "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",                                         desc = "[HARPOON] View file menu",                    nowait = true, remap = false },
	{ "<leader>hx",       "<cmd>lua require('harpoon.term').gotoTerminal(2)<cr>",                                           desc = "[HARPOON] Go to Terminal 2 (extra)",          nowait = true, remap = false },
	{ "<leader>l",        group = "[LSP]",                                                                                  nowait = true,                                        remap = false },
	{ "<leader>le",       "<cmd>lua vim.diagnostic.open_float()<cr>",                                                       desc = "[LSP] View diagnosticson cursor",             nowait = true, remap = false },
	{ "<leader>t",        group = "[TEST]",                                                                                 nowait = true,                                        remap = false },
	{ "<leader>tf",       "<cmd>TestFile<cr>",                                                                              desc = "[TEST] Current file",                         nowait = true, remap = false },
	{ "<leader>tl",       "<cmd>TestLast<cr>",                                                                              desc = "[TEST] Last test",                            nowait = true, remap = false },
	{ "<leader>ts",       "<cmd>TestSuite<cr>",                                                                             desc = "[TEST] Test suite",                           nowait = true, remap = false },
	{ "<leader>tt",       "<cmd>TestNearest<cr>",                                                                           desc = "[TEST] Nearest test",                         nowait = true, remap = false },
	{ "<leader>tv",       "<cmd>TestVisit<cr>",                                                                             desc = "[TEST] Visit test",                           nowait = true, remap = false },
	{ "<leader>x",        group = "[TROUBLE]",                                                                              nowait = true,                                        remap = false },
	{ "<leader>xd",       "<cmd>TroubleToggle document_diagnostics<cr>",                                                    desc = "[TROUBLE] Document diagnostics",              nowait = true, remap = false },
	{ "<leader>xl",       "<cmd>TroubleToggle loclist<cr>",                                                                 desc = "[TROUBLE] Visit test",                        nowait = true, remap = false },
	{ "<leader>xq",       "<cmd>TroubleToggle quickfix<cr>",                                                                desc = "[TROUBLE] Quickfix",                          nowait = true, remap = false },
	{ "<leader>xw",       "<cmd>TroubleToggle workspace_diagnostics<cr>",                                                   desc = "[TROUBLE] Workspace diagnostics",             nowait = true, remap = false },
	{ "<leader>xx",       "<cmd>TroubleToggle<cr>",                                                                         desc = "[TROUBLE] Toggle menu",                       nowait = true, remap = false },
	{ "N",                "Nzz",                                                                                            desc = "[MOVEMENT] Center 'N' search",                nowait = true, remap = false },
	{ "Y",                "y$",                                                                                             desc = "Y behaves like C and D",                      nowait = true, remap = false },
	{ "[d",               "<cmd>lua vim.diagnostic.goto_prev()<cr>",                                                        desc = "[LSP] Previous diagnostic",                   nowait = true, remap = false },
	{ "[q",               "<cmd>cprevious<cr>",                                                                             desc = "[MOVEMENT] Previous quickfix",                nowait = true, remap = false },
	{ "[t",               "<cmd>tabp<cr>",                                                                                  desc = "[MOVEMENT] Previous tab",                     nowait = true, remap = false },
	{ "]d",               "<cmd>lua vim.diagnostic.goto_next()<cr>",                                                        desc = "[LSP] Next diagnostic",                       nowait = true, remap = false },
	{ "]q",               "<cmd>cnext<cr>",                                                                                 desc = "[MOVEMENT] Next quickfix",                    nowait = true, remap = false },
	{ "]t",               "<cmd>tabn<cr>",                                                                                  desc = "[MOVEMENT] Next tab",                         nowait = true, remap = false },
	{ "g#",               "g#zz",                                                                                           desc = "[MOVEMENT] Center 'g#' search",               nowait = true, remap = false },
	{ "g*",               "g*zz",                                                                                           desc = "[MOVEMENT] Center 'g*' search",               nowait = true, remap = false },
	{ "n",                "nzz",                                                                                            desc = "[MOVEMENT] Center 'n' search",                nowait = true, remap = false },
})

wk.setup {}
